data "azurerm_subnet" "subnet_ids" {
  count                = length(var.module_config.network_config.subnet_names)
  name                 = var.module_config.network_config.subnet_names[count.index]
  virtual_network_name = var.module_config.network_config.vnet_name
  resource_group_name  = var.module_config.network_config.vnet_rg
}

data "azurerm_resource_group" "rg" {
  count = try(var.module_config.resource_group_name, null) == null ? 0 : 1
  name  = var.module_config.resource_group_name
}