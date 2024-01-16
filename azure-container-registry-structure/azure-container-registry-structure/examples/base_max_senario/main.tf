provider "azurerm" {
  features {}
}


module "azurerm_container_registry_example" {
  source                  = "../../"
  config = var.config
  runtime = var.runtime
  container_registry_base = var.config.container_registry_base
}

locals {
  aggregate_output = {
    azurerm_container_registry_example : module.azurerm_container_registry_example.out
  }
}