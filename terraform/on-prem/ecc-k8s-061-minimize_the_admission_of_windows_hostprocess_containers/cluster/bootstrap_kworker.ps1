<powershell>
echo "Start of user data output" 
Start-Transcript -Path c:\logs-worker.log -Append

New-NetFireWallRule -DisplayName "Allow All Traffic" -Direction OutBound -Action Allow 
New-NetFireWallRule -DisplayName "Allow All Traffic" -Direction InBound -Action Allow 

Write-Output "Checking if AWS CLI support exists..." 
cmd.exe /c "aws --version" 
if ($LASTEXITCODE -eq 0){
    Write-Output "AWS CLI installed already" 
} else {
    Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
    $arguments = "/i `"C:\AWSCLIV2.msi`" /quiet"
    Start-Process msiexec.exe -ArgumentList $arguments -Wait
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
    aws --help 
}
cmd.exe /c "kubeadm version"
if ($LASTEXITCODE -eq 0){
    Write-Output "Kubeadm installed already" 
} else {
    aws s3 cp s3://${bucket}/ C:\ --recursive --exclude "*.yaml" 
    C:\Install-Containerd.ps1 
    Write-Output "Install-Containerd.ps1 finished!" 
    sleep 60
    Write-Output "After sleeping 60 sec"

    New-Item c:\k -ItemType Directory  
    New-Item C:\Users\Administrator\.ssh -ItemType Directory 

    whoami 
    if(-not(Test-path "C:\Users\Administrator\.ssh\id_rsa" -PathType leaf))
    {
        New-Item C:\Users\Administrator\.ssh\id_rsa -Value "${private_key}" -ItemType file 
        $id_rsa_path = "C:\Users\Administrator\.ssh\id_rsa"
        icacls.exe $id_rsa_path /reset 
        icacls.exe $id_rsa_path /GRANT:R "SYSTEM:(R)" 
        #icacls.exe $id_rsa_path /GRANT:R "Administrator:(R)" 
        icacls.exe $id_rsa_path /inheritance:r  
    }

    New-Item C:\Users\Administrator\.kube -ItemType Directory 

    Write-Output "Coping config file from Master" 
    scp -i  C:\Users\Administrator\.ssh\id_rsa -o StrictHostKeyChecking=no ubuntu@${master_ip}:/home/ubuntu/.kube/config "C:\Users\Administrator\.kube" 

    Write-Output "Coping file to C:\k" 
    cp "C:\Users\Administrator\.kube\config" "C:\k\" 

    Write-Output "Coping joincluster.ps1 from Master" 
    scp -i  C:\Users\Administrator\.ssh\id_rsa -o StrictHostKeyChecking=no ubuntu@${master_ip}:/joincluster.ps1 "C:\joincluster.ps1" 

    Start-Process powershell.exe -Wait -Verb RunAs -ArgumentList 'C:\PrepareNode.ps1', "`"-KubernetesVersion v1.25.3`""
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")     
    
    C:\joincluster.ps1
}
Stop-Transcript
</powershell>
<persist>true</persist>