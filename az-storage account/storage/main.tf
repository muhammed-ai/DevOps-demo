module "naming" {
  source = "../naming"
  prefix = [var.module_config.project, var.module_config.environment]
}

resource "azurerm_storage_account" "name" {
  name                     =module.naming.storage_account.name
  resource_group_name      = var.module_config.resource_group_name
  location                 = var.module_config.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "example" {
  name                  = module.naming.storage_account.name
  storage_account_name  = module.naming.storage_account.name
  container_access_type = var.container_access_type
}
