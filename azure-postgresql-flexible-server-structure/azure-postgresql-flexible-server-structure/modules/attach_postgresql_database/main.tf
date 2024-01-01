#                           PoC
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
resource "azurerm_postgresql_flexible_server_database" "instance" {
  for_each    = var.postgresql_flexible_server_attach_postgresql_database
  name        = each.value.name == null ? "${module.naming.postgresql_database.name}-${each.key}" : each.value.name
  server_id   = each.value.server_id
}
