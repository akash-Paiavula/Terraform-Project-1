output "private_subnet_id" {
    value = [for subnet in aws_subnet.Private_subnets : subnet.id]
  
}
output "public_subnet_id" {
    value = [for subnet in aws_subnet.Public_subnets : subnet.id]
  
}


output "vpc_id" {
  value = aws_vpc.akash_vpc.id
}


output "cidr_block" {
    value = aws_vpc.akash_vpc.cidr_block
  
}