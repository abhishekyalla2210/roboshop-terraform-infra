data "aws_ssm_parameter" "backend_alb_sg_ids" {
  name = "/${local.common_name_suffix}/backend_alb"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${local.common_name_suffix}/public_subnet_ids"
}

resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  name  = "/${var.project_name}-${var.environment_name}/backend_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.backend_alb.arn
}

data "aws_ssm_parameter" "private_subnet" {
  name = "/${local.common_name_suffix}/private_subnet_ids"
}
