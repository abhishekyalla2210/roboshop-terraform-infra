
  
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${local.common_name}/catalogue"
  }

  
data "aws_ssm_parameter" "private_subnet_id" {
  name = "/${local.common_name}/private_subnet_ids"
  }

  