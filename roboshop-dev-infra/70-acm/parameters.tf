resource "aws_ssm_parameter" "roboshop_arn" {
    name = "/${var.project_name}-${var.environment}/roboshop_arn"
    type = string
    value = aws_acm_certificate.roboshop.arn
}