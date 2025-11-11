locals {
  common_name_suffix = "${var.project_name}-${var.environment_name}"
  sg_name = data.aws_ssm_parameter.sg_ids.value
}