  
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



  

resource "aws_route53_record" "catalogue" {
  

  zone_id = "Z01730921MDPIK694OSXC"

  name    = "catalogue-${var.environment_name}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
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







   