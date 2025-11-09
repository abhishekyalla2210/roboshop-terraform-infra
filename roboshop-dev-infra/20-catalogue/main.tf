  
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
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment_name}"
      ] 
    }  
    }

   