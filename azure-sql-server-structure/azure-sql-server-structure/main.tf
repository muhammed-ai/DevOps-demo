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

resource "azurerm_sql_server" "instance" {
  for_each            = var.sql_server_base
  name                = each.value.name == null ? "${module.naming.sql_server.name}-${each.key}" : each.value.name
  location            = each.value.location 
  resource_group_name = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
  version             = each.value.version
  administrator_login           = each.value.administrator_login
  administrator_login_password  = each.value.administrator_login_password
  tags                          = merge(module.tags.get_tags, { "ResourceType" : module.naming.sql_server.slug })
}

module "attach_sql_database" {
  source                           = "./modules/attach_sql_database"
  for_each                         = var.sql_server_base
  sql_server_attach_sql_database   = each.value.attach_sql_database != null ? each.value.attach_sql_database : {}
  config                           = var.config
  runtime                          = var.runtime
}
