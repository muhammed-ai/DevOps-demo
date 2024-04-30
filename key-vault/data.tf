data "azurerm_client_config" "current" {}

data "azurerm_subnet" "subnet_ids" {
  count                = length(var.module_config.network_config.subnet_names)
  name                 = var.module_config.network_config.subnet_names[count.index]
  virtual_network_name = var.module_config.network_config.vnet_name
  resource_group_name  = var.module_config.network_config.vnet_rg
}

# Use the data source to look up the resource group
data "azurerm_resource_group" "rg" {
  name = var.module_config.resource_group_name
}

data "azurerm_storage_account" "sa" {
  name                = var.module_config.environment == "prod" ? local.storage_account_name["prod"] : local.storage_account_name["nonprod"]
  resource_group_name = local.storage_account_rg
  provider            = azurerm.foundation
}
