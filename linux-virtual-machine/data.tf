# Use the data source to look up the client configuration
data "azurerm_client_config" "current" {}

# Use the data source to look up the virtual network and subnet
data "azurerm_virtual_network" "vnet" {
  name                = local.network_config.vnet_name
  resource_group_name = local.network_config.vnet_rg_name
}
data "azurerm_subnet" "subnet" {
  name                 = local.network_config.subnet_name
  virtual_network_name = local.network_config.vnet_name
  resource_group_name  = local.network_config.vnet_rg_name
}

# Use the data source to look up the shared image version
data "azurerm_shared_image_version" "image_version" {
  provider            = azurerm.foundation
  name                = local.vm_config.vm_shared_image_version.name
  image_name          = local.vm_config.vm_shared_image_version.image_name
  gallery_name        = local.vm_config.vm_shared_image_version.gallery_name
  resource_group_name = local.vm_config.vm_shared_image_version.resource_group_name
}

# Use the data source to look up the SSH public key
data "azurerm_ssh_public_key" "sshkey" {
  provider            = azurerm.foundation
  name                = "cloudadmin"
  resource_group_name = local.cloud_foundation_defaults["resource_group_name"]
}

# Use the data source to look up the key vault
data "azurerm_resources" "kv_data" {
  type = "Microsoft.KeyVault/vaults"
  required_tags = {
    Project     = var.module_config.project
    Environment = var.module_config.environment
    Type        = "LZ"
  }
}
