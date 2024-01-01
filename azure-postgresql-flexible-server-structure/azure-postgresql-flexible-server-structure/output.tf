output "out" {
  value = {
    for key, value in var.postgresql_flexible_server_base :
    key => {
      id                          = azurerm_postgresql_flexible_server.instance[key].id
      name                        = azurerm_postgresql_flexible_server.instance[key].name
      resource_group              = azurerm_postgresql_flexible_server.instance[key].resource_group_name
      attach_postgresql_database  = module.attach_postgresql_database[key].out
    }
  }
  description = "The output from azuure postgresql server"
  sensitive   = false
}