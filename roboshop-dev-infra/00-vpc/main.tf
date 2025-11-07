module "vpc" {

    source = "git::https://github.com/abhishekyalla2210/terraforms.git"
    cidr_block = var.cidr_block
    project_name = var.project_name
    environment = var.environment
    public_subnet_cidr = var.public_subnet_cidr 
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr
}
