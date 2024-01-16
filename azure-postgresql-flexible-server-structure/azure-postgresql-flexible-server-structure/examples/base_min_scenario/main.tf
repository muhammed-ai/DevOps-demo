provider "azurerm" {
  features {}
}

module "azurerm_postgresql_flexible_server_example" {
  source              = "../../"
  config       = var.config
  postgresql_flexible_server_base     = var.postgresql_flexible_server_base
}

locals {
  aggregate_output = {
    postgresql_flexible_server : module.azurerm_postgresql_flexible_server_example.out
  }
}