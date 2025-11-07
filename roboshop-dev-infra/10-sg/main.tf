resource "aws_security_group" "sg" {
    count = length(var.sg_names)
  name        = var.sg_names[count.index]
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
}


 


resource "aws_vpc_security_group_ingress_rule" "frontend_allowing_frontendlb" {
    
  security_group_id = aws_security_group.sg[9].id
  referenced_security_group_id = aws_security_group.sg[11].id
  from_port         = 80
  ip_protocol = "tcp"
  to_port           = 80
}


# resource "aws_lb" "test" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]

#   enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

#   tags = {
#     Environment = "production"
#   }
# }