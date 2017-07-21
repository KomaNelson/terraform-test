#AWS Provider
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}
#Bucket Creation
resource "aws_s3_bucket" "trial_bucket" {
  bucket = "${var.aws_bucket_name}"
  acl    = "private"

  tags {
    Project     ="${var.aws_project_name}"
    Environment = "Dev"
  }
  #Writing the bucket ARN to a file for later use
  provisioner "local-exec" {
    command     = "echo Bucket ARN: ${aws_s3_bucket.trial_bucket.arn} > outputs.txt"
    }
}
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.trial_bucket.arn}"
}
