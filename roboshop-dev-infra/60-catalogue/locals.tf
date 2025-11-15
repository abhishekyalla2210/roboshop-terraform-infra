locals {
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
     common_name = "${var.project_name}-${var.environment_name}"
  subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
vpc_id = data.aws_ssm_parameter.vpc_id.value
ami_id = data.aws_ami.ami_id.id
}


locals {
  common_tags = {
    Project = var.project_name
    Environment = var.environment_name
    terraform = true
  }


}