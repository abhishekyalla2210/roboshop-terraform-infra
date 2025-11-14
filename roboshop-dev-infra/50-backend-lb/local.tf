locals {
  common_name_suffix = "${var.project_name}-${var.environment_name}"
  backend_alb_sg_name = data.aws_ssm_parameter.backend_alb_sg_ids.value
  private_subnet = split(",",data.aws_ssm_parameter.private_subnet.value)

}