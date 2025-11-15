module "main"{
    source = "git::https://github.com/abhishekyalla2210/roboshop-terraform-module.git?ref=main"
  
    for_each = var.components
    component = each.key
    rule_priority = each.value.priority
    domain_name = var.domain_name
}

