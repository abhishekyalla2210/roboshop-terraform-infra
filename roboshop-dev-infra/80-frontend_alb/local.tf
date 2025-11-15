locals {
  common_name_suffix = "${var.project_name}-${var.environment_name}"
  public_subnet = split(",",data.aws_ssm_parameter.public_subnet.value)
  frontend_alb_sg_name = data.aws_ssm_parameter.frontend_alb_sg_ids.value
  certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
}