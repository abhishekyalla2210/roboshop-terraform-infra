# resource "aws_security_group_rule" "backend_alb_bastion" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value


#   security_group_id = data.aws_ssm_parameter.backend_alb.value
# }

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks =    ["0.0.0.0/0"]

 
  security_group_id = local.bastion_sg_id
}


resource "aws_instance" "bastion" {
    ami = var.ami_id
    subnet_id   = split("," , data.aws_ssm_parameter.public_subnet.value)[0]
    instance_type = "t3.micro"  
    vpc_security_group_ids = [local.bastion_sg_id]
         
    user_data = file("bastion.sh")
        
    tags = {
      Name = "${local.common_name_suffix}-bastion"
    }


}

output "public_id" {

  value = aws_instance.bastion.public_ip
}


resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongodb_sg_id
}


resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}


resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}


resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}
