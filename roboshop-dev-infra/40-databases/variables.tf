variable "project_name" {
    type = string
    default = "roboshop"
}

variable "environment_name" {
    type = string
    default = "dev"
  
}

variable "instance_type" {
    default = "t3.micro"
  
}



variable "route_names" {
    type = list
    default = ["mongodb", "rabbitmq", "redis", "mysql"]
}



variable "domain" {
    type = string
    default = "abhishekdev.fun"
  
}



