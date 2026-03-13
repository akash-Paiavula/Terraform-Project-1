module "s3_bucket" {
    source = "./modules/s3_buckets"
    env_name = var.env_name
  
}