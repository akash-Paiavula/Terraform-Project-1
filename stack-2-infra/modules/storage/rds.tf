locals {
  db_password = sensitive(data.aws_ssm_parameter.rds_db_password.value)
}


resource "aws_db_subnet_group" "private_sg" {
    name = "akash-${var.env_name}-subnet-group"
    subnet_ids = var.private_subnet_ids

    tags = {
      Name = "akash-${var.env_name}-subnet-group"
    }
  
}

resource "aws_security_group" "db_sg" {
    name = "akash-${var.env_name}-db-sg"
    description = "Security group for RDS instance"
    vpc_id = var.vpc_id

    tags = {
      Name = "akash-${var.env_name}-db-sg"
    }
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic" {
    security_group_id = aws_security_group.db_sg.id
    from_port = 3306
    to_port = 3306
    ip_protocol = "tcp"
    cidr_ipv4 = var.vpc_cidr  
}


resource "aws_db_instance" "rds_db" {
  identifier          = "akash-${var.env_name}-db-instance"
  allocated_storage   = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  username            = var.rds_db_username
  password            = local.db_password
  db_subnet_group_name    = aws_db_subnet_group.private_sg.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  deletion_protection     = false
  storage_encrypted       = true
  kms_key_id              = data.aws_kms_key.aws_managed_rds_key.arn

  tags = {
    Name = "akash-${var.env_name}-db-instance"
  }
}