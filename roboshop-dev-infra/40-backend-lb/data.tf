data "aws_ssm_parameter" "sg_ids" {
  name = "/${local.common_name_suffix}/${var.sg_names[12]}"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${local.common_name_suffix}/public_subnet_ids"
}

resource "aws_ssm_parameter" "backend_alb_listner_arn" {
  name = "/${var.project_name}-${var.environment_name}/backend_alb_listner_arn"
  type = string
  value = aws_lb.backend_alb.arn
}