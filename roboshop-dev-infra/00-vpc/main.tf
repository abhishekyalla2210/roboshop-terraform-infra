module "vpc" {

    source = "git::https://github.com/abhishekyalla2210/vpc-module.git"
cidr_block = var.cidr_block
    project_name = var.project_name
    environment = var.environment
    

    
    public_subnet_cidr = var.public_subnet_cidrs

 
    private_subnet_cidr = var.private_subnet_cidrs

   

    database_subnet_cidr = var.database_subnet_cidrs

    is_peering_required = true
}