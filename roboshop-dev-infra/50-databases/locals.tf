locals {
  # ami_id = data.aws_ami_ids.ami_id.ids
  common_name = "${var.project_name}-${var.environment_name}"
  subnet_id = split("," , data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongodb_sg_id = [data.aws_ssm_parameter.mongodb_sg_id.value]
  redis_sg_id = [data.aws_ssm_parameter.redis_sg_id.value]
  rabbitmq_sg_id = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  mysql_sg_id = [data.aws_ssm_parameter.mysql_sg_id.value]
    catalogue_sg_id = [data.aws_ssm_parameter.catalogue_sg_id.value]

  # private_ip = [aws_instance[var.[count.index]].private_ip]
  # private_ip = [for name in var.route_names : name => [aws_instance.[name].private_ip]]

}

locals {
  common_tags = {
    Project = var.project_name
    Environment = var.environment_name
    terraform = true
  }

}


locals {
  instance_private_ips = {
    mongodb  = aws_instance.mongodb.private_ip
    rabbitmq = aws_instance.rabbitmq.private_ip
    redis    = aws_instance.redis.private_ip
    mysql    = aws_instance.mysql.private_ip
    # catalogue = aws_instance.catalogue.private_ip
    catalogue    = aws_instance.catalogue.private_ip

   }
}
