###########################################################
# EC2 Instance to Bake AMI
###########################################################
resource "aws_instance" "catalogue" {
  ami                    = var.ami_id
  subnet_id              = local.subnet_id
  instance_type          = var.instance_type
  vpc_security_group_ids = local.catalogue_sg_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.common_name}-catalogue"
    }
  )
}

###########################################################
# Provision catalogue on EC2
###########################################################
resource "terraform_data" "catalogue" {
  triggers_replace = [aws_instance.catalogue.id]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue"
    ]
  }
}

###########################################################
# AMI from Running Instance (no stop!)
###########################################################
resource "aws_ami_from_instance" "catalogue" {
  source_instance_id = aws_instance.catalogue.id
  name               = "${local.common_name}-catalogue-ami"
  depends_on         = [terraform_data.catalogue]
}

###########################################################
# Load Balancer Target Group
###########################################################
resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
    matcher             = "200-299"
    path                = "/health"
    protocol            = "HTTP"
    port                = 8080
  }
}

###########################################################
# Launch Template for ASG
###########################################################
resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = local.catalogue_sg_id

  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, { Name = "${local.common_name}-catalogue" })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.common_tags, { Name = "${local.common_name}-catalogue" })
  }

  tags = merge(local.common_tags, { Name = "${local.common_name}-catalogue" })
}

###########################################################
# Autoscaling Group
###########################################################
resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name}-catalogue"
  max_size                  = 10
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  vpc_zone_identifier       = local.private_subnet_ids
  target_group_arns         = [aws_lb_target_group.catalogue.arn]

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  dynamic "tag" {
    for_each = merge(local.common_tags, { Name = "${local.common_name}-catalogue" })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }
}

###########################################################
# Autoscaling Policy (CPU Scaling)
###########################################################
resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name                   = "${local.common_name}-catalogue"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

###########################################################
# Listener Rule for Backend ALB
###########################################################
resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.environment_name}.${var.domain}"]
    }
  }
}
