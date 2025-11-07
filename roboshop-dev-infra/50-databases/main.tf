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
        inline = [ 
            echo "Hello"
         ]
          }
}
