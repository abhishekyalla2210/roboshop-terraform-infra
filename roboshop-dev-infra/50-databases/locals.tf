locals {
  # ami_id = data.aws_ami_ids.ami_id.ids
  common_name = "${var.project_name}-${var.environment_name}"
  subnet_id = split("," , data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongodb_sg_id = [data.aws_ssm_parameter.mongodb_sg_id.value]
  redis_sg_id = [data.aws_ssm_parameter.redis_sg_id.value]
  rabbitmq_sg_id = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  mysql_sg_id = [data.aws_ssm_parameter.mysql_sg_id.value]


}

locals {
  common_tags = {
    Project = var.project_name
    Environment = var.environment_name
    terraform = true
  }

}