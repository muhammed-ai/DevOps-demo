output "out" {
  value = {
    for key, value in var.sql_server_base :
    key => {
      id                       = azurerm_sql_server.instance[key].id
      name                     = azurerm_sql_server.instance[key].name
      resource_group           = azurerm_sql_server.instance[key].resource_group_name
      attach_sql_database      = module.attach_sql_database[key].attach_sql_database
    }
  }
  description = "The output from azuure sql server"
  sensitive   = false
}
