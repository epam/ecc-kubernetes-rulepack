resource "aws_iam_instance_profile" "this" {
  name = "k8s-061-instance_profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name               = "k8s-061-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
     }
}
EOF
}

resource "aws_iam_role_policy" "this" {
  name   = "k8s-061-policy"
  role   = aws_iam_role.this.id
  policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:Get*",
          "s3:List*"
        ],
        "Resource": [
          "${aws_s3_bucket.this.arn}","${aws_s3_bucket.this.arn}/*"
        ]
      }
    ]
  }
  POLICY
}