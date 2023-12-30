provider "azurerm" {
  features {}
}

#Create Azure Storage Account required for Function App
resource azurerm_storage_account "primary" {
  name                     = "demoblobaccount"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#Create a Blob container within a storage account
resource azurerm_storage_container "demoblobs" {
  name                  = "demoblobstorage"
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "private"
}