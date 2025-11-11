  
resource "aws_instance" "catalogue" {
    ami = var.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.catalogue_sg_id
     tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-catalogue"
        }
    )
}

resource "terraform_data" "catalogue" {

    triggers_replace = [
        aws_instance.catalogue.id
    ]
     connection {
        type        = "ssh"
        user        = "ec2-user"
        password  = "DevOps321"
        host        = aws_instance.catalogue.private_ip
  }
      provisioner "file" {
        source = "catalogue.sh"  
        destination = "/tmp/catalogue.sh"
      }
     provisioner "remote-exec" { 
     inline =   [
        "sudo chmod +x /tmp/catalogue.sh",
        "sudo sh /tmp/catalogue.sh catalogue"
      ] 
    }  
    }



  



resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  source_instance_id = aws_instance.catalogue.id
  name               = "${local.common_name}-catalogue-ami"
  depends_on = [ aws_ec2_instance_state.catalogue ]
  }


resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   =  data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 60
    
     health_check {
    path                = "/health"
    port = 8080
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 10
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


resource "aws_launch_template" "catalogue" {
  name = "${local.common_name}-catalogue"


  instance_initiated_shutdown_behavior = "terminate"
  image_id = aws_ami_from_instance.catalogue.id
  instance_type = "t3.micro"
  vpc_security_group_ids = local.catalogue_sg_id
 tag_specifications {
   resource_type = "instance"
 

 tags = merge(
  local.common_tags,
  {
    Name = local.common_name
  }
 ) 
 }
  tag_specifications {
   resource_type = "volume"
  tags = merge(
  local.common_tags,
  {
    Name = "${local.common_name}-catalogue"
  }
 ) 
  
  }
}



resource "aws_autoscaling_group" "catalogue" {
  name = "${local.common_name}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  target_group_arns = [aws_lb_target_group.catalogue.arn]
  depends_on = [ aws_lb_target_group.catalogue ]
  launch_template {
    id = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }
  vpc_zone_identifier       = local.private_subnet_id

  
  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name}-catalogue"
      }
    )
  

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


resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name = "${local.common_name}-catalogue"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
    
  }
 }


resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend_alb-${var.environment_name}.${var.domain}"]
    }
  }
}




















   