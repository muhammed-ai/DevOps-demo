resource "azurerm_sql_database" "instance" {
  for_each              = var.sql_server_attach_sql_database
  name                  = each.value.name == null ? "${module.naming.sql_database.name}-${each.key}" : each.value.name
  location              = each.value.location 
  resource_group_name   = each.value.resource_group_name == null ? "${module.naming.resource_group.name}-${each.key}" : each.value.resource_group_name
  server_name           = each.value.server_name
}