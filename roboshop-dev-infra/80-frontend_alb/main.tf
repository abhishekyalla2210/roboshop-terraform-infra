
resource "aws_lb" "frontend_alb" {
  name               = "${local.common_name_suffix}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_name]
  subnets            = local.public_subnet

  enable_deletion_protection = false



}
resource "aws_lb_listener" "frontend_alb" {
  load_balancer_arn = aws_lb.frontend_alb.arn # Reference to your ALB resource
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = local.certificate_arn # Reference to your ACM certificate

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"

      message_body = "from frontend bro"
      status_code = 200
    }
  }
}


resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id# Reference your Route 53 hosted zone
  name    = "roboshop-${var.environment_name}.${var.domain_name}-frontend-alb"                  # The subdomain you want to use
  type    = "A"

  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true # Optional: Evaluate ALB health for Route 53 health checks
  }
}
