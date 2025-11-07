output "vpc_name" {
    value = module.vpc.vpc_id
}

output "public_subnet_ids" {
    value = aws_subnet.public
}