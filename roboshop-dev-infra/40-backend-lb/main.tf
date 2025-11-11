

resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.sg_name]
  subnets            = split("," , data.aws_ssm_parameter.public_subnet.value)


  enable_deletion_protection = false



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
resource "aws_route53_record" "backend_alb" {
  zone_id = "Z01730921MDPIK694OSXC" # Reference your Route 53 hosted zone
  name    = "*.backend_alb-${var.environment_name}.${var.domain_name}"                  # The subdomain you want to use
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true # Optional: Evaluate ALB health for Route 53 health checks
  }
}