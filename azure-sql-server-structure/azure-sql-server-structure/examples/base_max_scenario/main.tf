provider "azurerm" {
  features {}
}

module "azurerm_sql_server_example" {
  source          = "../.."
  config          = var.config
  runtime         = var.runtime 
  sql_server_base = var.sql_server_base
}

locals {
  aggregate_output = {
    sql_server : module.azurerm_sql_server_example.out
  }
}
