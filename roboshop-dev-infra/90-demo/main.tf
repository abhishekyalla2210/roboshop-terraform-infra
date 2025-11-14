module "main"{
    source = "git::https://github.com/abhishekyalla2210/roboshop-terraform-module.git?ref=main"
    ami_id = var.ami_id
    for_each = var.components
    component = each.key
    rule_priority = each.value.priority
    domain_name = var.domain_name
}

