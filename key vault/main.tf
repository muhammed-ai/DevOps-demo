provider "azurerm" {
  features {}
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "keyvault101demo"
  location                    = var.location
  resource_group_name         = var.resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.tenant_id

    key_permissions = [
      "Create",
      "Delete",
      "Get",
      "Purge",
      "Recover",
      "Update",
      "GetRotationPolicy",
      "SetRotationPolicy",
      "Get",
    ]

    secret_permissions = [
      "Get",
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
