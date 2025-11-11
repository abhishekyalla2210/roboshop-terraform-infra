locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
 mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
 redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
 rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
 mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
 catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
backend_alb_sg_id = data.aws_ssm_parameter.backend_alb.value
public_subnet_id = split("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]


}