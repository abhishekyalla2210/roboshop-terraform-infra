data "aws_caller_identity" "owner_id" {

}


data "aws_ami_ids" "ami_id" {
  owners = [data.aws_caller_identity.owner_id.account_id]

  
}

data "aws_ssm_parameter" "database_subnet_id" {
  name = "/${local.common_name}/database_subnet_ids"
  }

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}-${var.environment_name}/vpc_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${local.common_name}/mongodb"
  }



data "aws_ssm_parameter" "public_subnet_id" {
  name = "/${local.common_name}/public_subnet_ids"
  }

data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${local.common_name}/redis"
  }



data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name = "/${local.common_name}/rabbitmq"
  }

  
data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${local.common_name}/mysql"
  }

   
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${local.common_name}/catalogue"
  }