

variable "priority" {
    default = 10
    }

    variable "domain_name" {
        default = "abhishekdev.fun"
      
    }
    variable "components" {
    default = {
        catalogue = {
            priority = 10
        }
        user = {
            priority = 20
        }
        cart = {
            priority = 30
        }
        shipping = {
            priority = 40
        }
        payment = {
            priority = 50
        }
        frontend = {
            priority = 60
        }
    }
}