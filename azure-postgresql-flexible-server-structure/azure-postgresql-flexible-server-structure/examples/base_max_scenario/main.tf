provider "azurerm" {
  features {}
}


module "attach_postgresql_database" {
  source              = "../../"
  config       = var.config
  postgresql_flexible_server_base     = var.postgresql_flexible_server_base
  runtime =  var.runtime
}

locals {
  aggregate_output = {
    postgresql_flexible_server : module.attach_postgresql_database.out
  }
}