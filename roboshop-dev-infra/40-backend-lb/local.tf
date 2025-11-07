locals {
  common_name_suffix = "${var.project_name}-${var.environment}"
  sg_name = data.aws_ssm_parameter.sg_ids.value
}