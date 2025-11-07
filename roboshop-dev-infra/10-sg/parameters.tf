resource "aws_ssm_parameter" "sg_ids" {
    count = length(var.sg_names)
  name  = "/${local.common_name_suffix}/${var.sg_names[count.index]}"
  type  = "String"
  value = aws_security_group.sg[count.index].id
}

