data "aws_ssm_parameter" "sg_ids" {
  name = "/${local.common_name_suffix}/${var.sg_names[12]}"
}

data "aws_ssm_parameter" "public_subnet" {
  name = "/${local.common_name_suffix}/public_subnet_ids"
}

