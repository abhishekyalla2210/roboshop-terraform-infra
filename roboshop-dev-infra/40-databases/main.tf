resource "aws_instance" "mongodb" {
    ami = var.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.mongodb_sg_id
    
    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-mongodb"
        }
    )


}

resource "terraform_data" "mongodb" {

    triggers_replace = [
        aws_instance.mongodb.id
    ]
     connection {
        type        = "ssh"
        user        = "ec2-user"
        password  = "DevOps321"
        host        = aws_instance.mongodb.private_ip
  }

      provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      }


     provisioner "remote-exec" { 
     inline =   [
        "sudo chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb"



      ] 

    }

  

      
    }


resource "aws_instance" "redis" {
    ami = var.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.redis_sg_id
    
    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-redis"
        }
    )


}

resource "terraform_data" "redis" {

    triggers_replace = [
        aws_instance.redis.id
    ]
     connection {
        type        = "ssh"
        user        = "ec2-user"
        password  = "DevOps321"
        host        = aws_instance.redis.private_ip
  }

      provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      }


     provisioner "remote-exec" { 
     inline =   [
        "sudo chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis"



      ] 

    }

  

      
    }

    
resource "aws_instance" "rabbitmq" {
    ami = var.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.rabbitmq_sg_id
    
    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-rabbitmq"
        }
    )


}

resource "terraform_data" "rabbitmq" {

    triggers_replace = [
        aws_instance.rabbitmq.id
    ]
     connection {
        type        = "ssh"
        user        = "ec2-user"
        password  = "DevOps321"
        host        = aws_instance.rabbitmq.private_ip
  }

      provisioner "file" {
        source = "bootstrap.sh"
       
        destination = "/tmp/bootstrap.sh"
      }


     provisioner "remote-exec" { 
     inline =   [
        "sudo chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh rabbitmq"



      ] 

    }

  

      
    }

    
   
resource "aws_instance" "mysql" {
    ami = var.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.mysql_sg_id
    iam_instance_profile = aws_iam_instance_profile.mysql.name

    
    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-mysql"
        }
    )

    
    }

    resource "aws_iam_instance_profile" "mysql" {
        name = "mysql"
         role = "EC2SSMParameterStore"
    }




resource "terraform_data" "mysql" {

    triggers_replace = [
        aws_instance.mysql.id
    ]
     connection {
        type        = "ssh"
        user        = "ec2-user"
        password  = "DevOps321"
        host        = aws_instance.mysql.private_ip
  }

      provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      }


     provisioner "remote-exec" { 
     inline =   [
        "sudo chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mysql"



      ] 

    }

  

      
    }


    
resource "aws_route53_record" "services" {
  for_each = local.instance_private_ips

  zone_id = "Z01730921MDPIK694OSXC"

  name    = "${each.key}-${var.environment_name}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [each.value]
  allow_overwrite = true
}







 



    











    







    





