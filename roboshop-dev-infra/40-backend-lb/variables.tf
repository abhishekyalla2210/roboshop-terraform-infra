variable "project_name" {
    type = string
    default = "roboshop"
  
}

variable "environment_name" {
    type = string
    default = "dev"
  
}

variable "sg_names" {
    type = list
    default = [
        "mongodb", "redis", "mysql", "rabbitmq",
        "catalogue", "user", "cart", "shipping", "payment",
        "frontend",
        "bastion",
        "frontend-alb",
        "backend-alb"
    ]
}

variable "domain_name" {
    type = string
    default = "abhishekdev.fun"
  
}
