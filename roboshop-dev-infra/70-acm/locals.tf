locals {
  common_tags = {
    Project = "${var.project_name}-${var.environment}"
    Name = "roboshop-dev"
    environment = "dev"

  }
}