#! /bin/bash
# set -x
set -e

check_count() { 
    cd $root_folder

    if [ -n "`grep -m 1 "green $1" tests/.exception_rules_with_resources_count | cut -d " " -f 3`" ];  then
        resources_count="`grep -m 1 "green $1" tests/.exception_rules_with_resources_count | cut -d " " -f 3`"
    else
        resources_count="0"
    fi
    kubectl config use-context $2
    custodian run --cache-period=0 -s output policies/on-prem/$1.yml
    returned_resources_count="$(custodian run --cache-period=0 -s output policies/on-prem/$1.yml 2>&1 | grep 'custodian' | cut -d ' '  -f 7 | cut -d ":" -f 2)"
    echo "RETURNED: $returned_resources_count / $resources_count"
    
    if [ "$returned_resources_count" = "$resources_count" ]; then
        echo "$3 $policy" >> .green_passed
    else
        echo "$3 $policy" >> .green_failed
    fi

    cd terraform/on-prem/$policy/$3
}


source custodian/bin/activate
kind create cluster --image kindest/node:v1.25.11 --name default

RULE_NAMES=$(find ./terraform/on-prem -maxdepth 1 -type d | tail -n +2 | awk -F '/' '{ print $NF }' | sort)
root_folder=$(pwd)

touch .green_passed .green_failed .whitelisted
mkdir -p output

echo "$RULE_NAMES" | while IFS=  read -r policy ; do
    echo "green test $policy executing..."
    
    WHITELISTED_RULE_NAMES=$(cat tests/.except_list)
    if [[ $WHITELISTED_RULE_NAMES =~ $policy ]]; 
    then echo $policy >> .whitelisted; continue; fi

    cd ./terraform/on-prem/$policy
    
    green_infra_folders="$(ls | { grep green || true;} )"

    [ ! -z "$green_infra_folders" ] && \
    for green_infra in $green_infra_folders; do
        cd $green_infra
        
        if [ -f "config.yaml" ]; then
            yaml_files="`ls *.yaml | { grep -v "config.yaml$" || true;}`"
            yaml_files=($yaml_files)
            for yaml_file in "${yaml_files[@]}" ; do
              sed -i 's/172.18.0.4/172.18.0.5/g' $yaml_file
              sed -i 's/172.18.0.3/172.18.0.4/g' $yaml_file
              sed -i 's/172.18.0.2/172.18.0.3/g' $yaml_file
            done

            kind create cluster --config config.yaml
            cluster_name=`kind get clusters | grep cluster-`
            check_count $policy kind-$cluster_name $green_infra
            kind delete clusters $cluster_name
            
        elif [ -f "default.md" ]; then
            check_count $policy kind-default $green_infra
        else
            kubectl config use-context kind-default
            terraform init
            terraform apply --auto-approve -var="context=`kubectl config current-context`"
            check_count $policy `kubectl config current-context` $green_infra
            terraform destroy --auto-approve -var="context=`kubectl config current-context`"
            rm -rf .terraform .terraform.lock.hcl terraform.tfstate*
        fi
        cd ..
    done
    cd $root_folder
done

kind delete cluster --name default

cd $root_folder
rm -rf output

echo "green tests executed"
echo "green_passed:"
cat .green_passed

echo "whitelisted_green:"
cat .whitelisted

echo "green_failed:"
cat .green_failed

test -s .green_failed && exit 1
exit 0
# set +x