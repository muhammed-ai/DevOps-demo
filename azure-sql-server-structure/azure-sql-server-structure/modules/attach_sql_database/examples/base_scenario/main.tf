provider "azurerm" {
  features {}
}

module "attach_sql_server_example" {
  source   = "../../" 
  config   = var.config
  runtime  = var.runtime
  sql_server_attach_sql_database = var.sql_server_attach_sql_database
}

locals {
  aggregate_output = {
    sql_server : module.attach_sql_server_example.out
  }
}