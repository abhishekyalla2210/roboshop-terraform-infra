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
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh"



    ] 

    }

  

      
    }




