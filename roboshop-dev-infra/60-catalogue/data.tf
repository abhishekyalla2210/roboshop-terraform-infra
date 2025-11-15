
  
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${local.common_name}/catalogue"
  }

  
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${local.common_name}/private_subnet_ids"
  }

  data "aws_instance" "catalogue" {
  instance_id = aws_instance.catalogue.id

  
}


   
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.common_name}/vpc_id"
  }

data "aws_ssm_parameter" "backend_alb_listener_arn" {
  name = "/${local.common_name}/backend_alb_listener_arn"
  }

data "aws_ami" "ami_id" {
  most_recent = true
  owners      = ["112108975903"]  # because it’s your AMI
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}

