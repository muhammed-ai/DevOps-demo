  value = {
    for map_key in keys((try(var.sql_server_attach_sql_database, null) != null) ? var.sql_server_attach_sql_database : {}) :
    map_key => {
      map_key                     = map_key
      id                          = azurerm_sql_database.instance[map_key].id
      name                        = azurerm_sql_database.instance[map_key].name
      resource_group_name         = azurerm_sql_database.instance[map_key].resource_group_name
      server_name                 = azurerm_sql_server.instance[map_key].server_name
  }
  }
  description = "The output from azurerm_sql_database"
  sensitive   = false
}
