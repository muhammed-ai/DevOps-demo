data "azurerm_virtual_network" "vnet" {
  name                = var.module_config.network_config.vnet_name
  resource_group_name = local.vnet_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.module_config.network_config.subnet_name
  virtual_network_name = var.module_config.network_config.vnet_name
  resource_group_name  = local.vnet_rg_name
}

data "azurerm_private_dns_zone" "priv_dns_zone" {
  provider            = azurerm.sharedservices 
  name                = local.priv_dns.name
  resource_group_name = local.priv_dns.dns_rg 
}

data "azurerm_container_registry" "acr" {
  name                = local.acr.name
  resource_group_name = local.acr.acr_rg
}