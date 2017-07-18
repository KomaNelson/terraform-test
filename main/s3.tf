#Basic S3 bucket creation
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "${var.test_bucket_name}"
  acl    = "public"
  tags {
    Name        = "Testing-Bucket"
    Environment = "QA"
  }
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.test_bucket.arn}"
}
