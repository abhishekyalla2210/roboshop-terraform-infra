module "vpc" {

    source = "../vpc-module-creation"
    cidr_block = var.cidr_block
    project_name = var.project_name
    environment = var.environment
    public_subnet_cidr = var.public_subnet_cidr 
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr
}

# data "aws_availability_zones" "available"{
#     state = "available"
# }

# output "azs" {
#    value = data.aws_availability_zones.available
# }