data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}-${var.environment}/vpc_id"
}


data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project_name}-${var.environment}/bastion"
}


data "aws_ssm_parameter" "backend_alb" {
  name = "/${var.project_name}-${var.environment}/backend_alb"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${local.common_name_suffix}/public_subnet_ids"
  }

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${local.common_name_suffix}/mongodb"
  }

  data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${local.common_name_suffix}/redis"
  }

 data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name = "/${local.common_name_suffix}/rabbitmq"
  }

 data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${local.common_name_suffix}/mysql"
  }

data "aws_availability_zones" "available" {
  state = "available"
}


 data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${local.common_name_suffix}/catalogue"
  }




 
 


 data "aws_ssm_parameter" "cart_sg_id" {
  name = "/${local.common_name_suffix}/cart"
  }


 data "aws_ssm_parameter" "shipping_sg_id" {
  name = "/${local.common_name_suffix}/shipping"
  }


 data "aws_ssm_parameter" "payment_sg_id" {
  name = "/${local.common_name_suffix}/payment"
  }


 data "aws_ssm_parameter" "user_sg_id" {
  name = "/${local.common_name_suffix}/user"
  }


 data "aws_ssm_parameter" "frontend_alb" {
  name = "/${local.common_name_suffix}/frontend_alb"
  }

data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${local.common_name_suffix}/frontend"
  }
  




# data "aws_vpc" "main" {
#   filter {
#     name   = "tag:Project"
#     values = [var.project_name]  # e.g., "roboshop"
#   }

#   filter {
#     name   = "tag:Environment"
#     values = [var.environment]   # e.g., "dev"
#   }

#   filter {
#     name   = "tag:terraform"
#     values = ["true"]
#   }
# }
