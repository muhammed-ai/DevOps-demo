output "out" {
  value = {
    for map_key in keys((try(var.postgresql_flexible_server_attach_postgresql_database, null) != null) ? var.postgresql_flexible_server_attach_postgresql_database : {}) :
    map_key => {
      map_key                     = map_key
      id                          = azurerm_postgresql_flexible_server_database.instance[map_key].id
      name                        = azurerm_postgresql_flexible_server_database.instance[map_key].name
      resource_group_name         = azurerm_postgresql_flexible_server_database.instance[map_key].resource_group_name
    }
  }
  description = "The output from azurerm_postgresql_flexible_server_database"
  sensitive   = false
}
