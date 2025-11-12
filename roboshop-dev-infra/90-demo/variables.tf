variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"

}

variable "priority" {
    default = 10
    }

    variable "domain_name" {
        default = "abhishekdev.fun"
      
    }
    variable "components" {
    default = {
        catalogue = {
            rule_priority = 10
        }
        user = {
            rule_priority = 20
        }
        cart = {
            rule_priority = 30
        }
        shipping = {
            rule_priority = 40
        }
        payment = {
            rule_priority = 50
        }
        frontend = {
            rule_priority = 10
        }
    }
}