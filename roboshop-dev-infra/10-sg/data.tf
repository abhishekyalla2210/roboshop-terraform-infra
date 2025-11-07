data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}-${var.environment}/vpc_id"
}


data "aws_vpc" "main" {
  filter {
    name   = "tag:Project"
    values = [var.project_name]  # e.g., "roboshop"
  }

  filter {
    name   = "tag:Environment"
    values = [var.environment]   # e.g., "dev"
  }

  filter {
    name   = "tag:terraform"
    values = ["true"]
  }
}
