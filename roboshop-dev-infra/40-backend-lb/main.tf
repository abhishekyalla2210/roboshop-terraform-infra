

resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.sg_name]
  subnets            = split("," , data.aws_ssm_parameter.public_subnet.value)


  enable_deletion_protection = true



}

resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "backend alb"
      status_code  = "200"
    }
  }
}