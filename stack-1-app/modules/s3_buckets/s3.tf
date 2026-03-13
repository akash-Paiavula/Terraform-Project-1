resource "aws_s3_bucket" "be_app_bucket" {
  bucket = "akash-${var.env_name}-be-app-bucket-1"
}

resource "aws_s3_bucket" "fe_app_bucket" {
  bucket = "akash-${var.env_name}-fe-app-bucket-1"
}