#!/bin/bash

mkdir terraform && cd terraform

if [ ! -x "$wget" ]; then
  echo "No wget, attempting installation" && \
  apt-get -qq update && \
  apt-get install -y wget
fi

wget "https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip?_ga=2.263138373.894661718.1499783053-363188929.1497437419" -O terraform.zip

if [ ! -x "$unzip" ]; then
  echo "No unzip, attempting installation" && \
  apt-get -qq update && \
  apt-get install -y unzip
fi

unzip terraform.zip
rm terraform.zip && cp terraform /usr/bin/

cat >s3.tf <<'EOF'
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}
resource "aws_s3_bucket" "trial_bucket" {
  bucket = "${var.aws_bucket}"
  acl    = "private"

  tags {
    Project     ="${var.aws_project_name}"
    Environment = "Dev"
  }

provisioner "local-exec" {
    command     = "echo Bucket ARN: ${aws_s3_bucket.trial_bucket.arn} > outputs.txt"
    }
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.trial_bucket.arn}"
}
EOF

cat >variables.tf <<'EOF'
variable "aws_region" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "prod_bucket_name" {}
variable "aws_bucket" {}

variable "aws_project_name" {}
EOF

cat >terraform.tfvars <<'EOF'
aws_region = "eu-west-1"

aws_access_key = "${}"
aws_secret_key = "${}"

prod_bucket_name = "nelson-script-concourse-bucket"
aws_bucket = "nelson-bucket-files"
aws_project_name = "Testing-Project"
EOF

terraform plan
#terraform apply
