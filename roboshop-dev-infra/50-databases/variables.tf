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

variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
  
}