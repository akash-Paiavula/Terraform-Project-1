module "asg" {
  source = "./modules/autoscaling"

  env_name = var.env_name
}