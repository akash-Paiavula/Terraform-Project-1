module "aws_vpc" {
    source = "./modules/networking"
    cidr_block = var.cidr_block
    env_name = var.env_name

    public_subnet_count = var.public_subnet_count
    private_subnet_count = var.private_subnet_count
    


}