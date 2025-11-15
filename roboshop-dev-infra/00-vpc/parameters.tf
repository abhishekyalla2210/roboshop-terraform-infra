resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${local.common_name}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
      
  name  = "/${local.common_name}/public_subnet_ids"
  type  = "StringList"
value = join("," , module.vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {

  name  = "/${local.common_name}/private_subnet_ids"
  type  = "StringList"
value = join("," , module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {

  name  = "/${local.common_name}/database_subnet_ids"
  type  = "StringList"
value = join("," , module.vpc.database_subnet_ids)
}    


resource "aws_ssm_parameter" "mysql_root_password" {

  name  = "/${local.common_name}/mysql_root_password"
  type  = "String"
  value = "RoboShop@1"
}