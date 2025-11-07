resource "aws_instance" "mongodb" {
    ami = local.ami_id
    subnet_id   = local.subnet_id
    instance_type = var.instance_type
    vpc_security_group_ids = local.mongodb_sg_id
    
    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-mongodb"
        }
    )

    provisioner "remote-exec" {
         
      
    }
}

resource "aws_instance" "bastion" {
    ami = local.ami_id
    subnet_id   = split("," , data.aws_ssm_parameter.public_subnet.value)[0]
    instance_type = "t3.micro"  
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    
}

output "public_id" {

  value = aws_instance.bastion.public_ip
}
