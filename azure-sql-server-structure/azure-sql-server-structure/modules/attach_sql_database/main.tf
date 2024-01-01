module "base" {
  source = "git::https://github.bnsf.com/HY/azure-common-base.git?ref=structure"
  config = var.config
}

module "naming" {
  source = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_naming?ref=structure"
  prefix = [var.config.entity.team_name, var.config.entity.app_name, var.config.entity.env_name]
}

module "tags" {
  source  = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_tags?ref=structure"
  config  = var.config
  runtime = var.runtime
}

resource "azurerm_sql_database" "instance" {
  for_each              = var.sql_server_attach_sql_database
  name                  = each.value.name == null ? "${module.naming.sql_database.name}-${each.key}" : each.value.name
  location              = each.value.location 
  resource_group_name   = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
  server_name           = each.value.server_name
}