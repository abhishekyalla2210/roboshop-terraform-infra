data "aws_ssm_parameter" "sg_ids" {
  name = "/${local.common_name_suffix}/backend_alb"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${local.common_name_suffix}/public_subnet_ids"
}


data "aws_ssm_parameter" "private_subnet" {
  name = "/${local.common_name_suffix}/private_subnet_ids"
}

resource "aws_ssm_parameter" "frontend_arn" {
  name  = "/${var.project_name}-${var.environment_name}/frontend_alb_arn"
  type  = "String"
  value = aws_lb_listener.frontend_alb.arn
}

data "aws_ssm_parameter" "certificate_arn" {
  name = "/${local.common_name_suffix}/roboshop_arn"
}


data "aws_ssm_parameter" "frontend_arn" {

  name = "/${local.common_name_suffix}/frontend_alb_listener_arn"
}


