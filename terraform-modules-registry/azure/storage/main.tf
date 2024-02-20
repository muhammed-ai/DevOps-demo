module "naming" {
  source = "../naming"
  prefix = [var.module_config.project, var.module_config.environment]
}

resource "azurerm_storage_account" "instance" {
  name                     = module.naming.storage_account.name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = module.naming.storage_container.name
  storage_account_name  = azurerm_storage_account.instance.name
  container_access_type = "private"  # allowed values: blob (private) or blob,container (public)
}

resource "azurerm_storage_blob" "blob" {
  name = module.naming.storage_blob.name
  #name                   = each.key == null ? "${module.naming.storage_blob .name}-${each.key}" : each.key  
  storage_account_name   = azurerm_storage_account.instance.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block" 
}

# resource "azurerm_storage_table" "table" {
#   name = module.naming.storage_table.name
#   #name                 = each.key == null ? "${module.naming.storage_table .name}-${each.key}" : each.key  
#   storage_account_name = azurerm_storage_account.instance.name
# }

#private endpoint to allow private connection to this  storage account from other resources in the vnet
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = module.naming.private_endpoint.name
  location            = local.location
  resource_group_name = local.resource_group_name
  subnet_id           = var.module_config.subnet_id

  private_service_connection {
    name                           = module.naming.private_link_service.name
    is_manual_connection           = false
    private_connection_resource_id =  azurerm_storage_account.instance.id
    subresource_names              = ["blob"]
  }
}
