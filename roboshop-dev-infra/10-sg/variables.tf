variable "project_name" {
    default = "roboshop"
}

variable "environment" {
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
