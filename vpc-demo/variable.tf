variable "cidr_block" {

    default = "10.0.0.0/16"
  
}

variable "instance_tenancy" {
    type = string
    default = "default" 
}

variable "project_name" {
    type = string
    default = "roboshop"
} 

variable "environment" {
    type = string
    default = "dev"
  
}
variable "agw" {

    type = map 
    default = {
        Name = "new gateway"
    }


  
}

variable "public_subnet_cidr" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
    
}


variable "private_subnet_cidr" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
    
}

variable "database_subnet_cidr" {
    default = ["10.0.15.0/24", "10.0.16.0/24"]
    
}


