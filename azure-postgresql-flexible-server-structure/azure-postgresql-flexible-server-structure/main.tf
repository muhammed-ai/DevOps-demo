module "base" {
  source        = "git::https://github.bnsf.com/HY/azure-common-base.git?ref=structure"
  config = var.config
  
}

module "naming" {
  source = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_naming?ref=structure"
  prefix = [var.config.entity.team_name, var.config.entity.app_name, var.config.entity.env_name]
}

module "tags" {
  source        = "git::https://github.bnsf.com/HY/azure-common-base.git//modules/base_tags?ref=structure"
  config =    var.config
  runtime       = var.runtime
}

resource "azurerm_postgresql_flexible_server" "instance" {
  for_each               = var.postgresql_flexible_server_base
  name                   = each.value.name == null ? "${module.naming.postgresql_server.name}-${each.key}" : each.value.name
  resource_group_name    = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
  location               = each.value.location
  version                = each.value.version
  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password
  sku_name               = each.value.sku_name
  storage_mb             = each.value.storage_mb
  backup_retention_days     = each.value.backup_retention_days
  tags                   = merge(module.tags.get_tags, { "ResourceType" : module.naming.postgresql_server.slug })

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? [each.value.maintenance_window] : []
    # for_each = lookup(each.value, "maintenance_window", false) ? [""] : []
    content {
      day_of_week   = each.value.day_of_week
      start_hour    = each.value.start_hour
      start_minute  = each.value.start_minute
      // duration      = each.value.duration can only be specified at tfvars
  }
  }
 

}
module "attach_postgresql_database" {
  source                                                   = "./modules/attach_postgresql_database"
  for_each                                                 = var.postgresql_flexible_server_base
  postgresql_flexible_server_attach_postgresql_database    =  each.value.attach_postgresql_database != null ? each.value.attach_postgresql_database : {}
  config                                            = var.config
  runtime                                                  = var.runtime
 
}