
resource "aws_lb" "frontend_alb" {
  name               = "${local.common_name_suffix}-frontend_alb"
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
  certificate_arn   = local.frontend_alb_listener_arn # Reference to your ACM certificate

  default_action {
    type             = "forward"
    target_group_arn = local.frontend_alb_listener_arn # Reference to your target group
  }
}


# resource "aws_route53_record" "frontend_alb" {
#   zone_id = "Z01730921MDPIK694OSXC" # Reference your Route 53 hosted zone
#   name    = "*.backend-alb-${var.environment_name}.${var.domain_name}"                  # The subdomain you want to use
#   type    = "A"

#   alias {
#     name                   = aws_lb.backend_alb.dns_name
#     zone_id                = aws_lb.backend_alb.zone_id
#     evaluate_target_health = true # Optional: Evaluate ALB health for Route 53 health checks
#   }
# }
