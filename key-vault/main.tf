# Calling the naming module to get the resource group name and other naming conventions
module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, var.module_config.environment]
}

# Create the Key Vault
resource "azurerm_key_vault" "vault" {
  name                        = coalesce(var.module_config.name, module.naming.key_vault.name_unique)
  location                    = local.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = local.key_vault_config.disk_encryption
  sku_name                    = local.key_vault_config.sku_name
  soft_delete_retention_days  = local.key_vault_config.soft_delete_retention_days
  purge_protection_enabled    = local.key_vault_config.purge_protection_enabled
  tags                        = local.module_tags

  # network_acls {
  #   bypass                     = "AzureServices"
  #   default_action             = "Deny"
  #   virtual_network_subnet_ids = data.azurerm_subnet.subnet_ids[*].id
  # }

  lifecycle {
    ignore_changes  = [tags["CreationDate"]]
    prevent_destroy = false
  }
  # TBD: Add network_acls once the network configuration is finalized.
  # network_acls {
  #   default_action = "Deny"
  #   bypass         = "AzureServices"
  #   ip_rules       = ["134.238.172.1"]
  #   virtual_network_subnet_ids = data.azurerm_subnet.subnet_ids[*].id
  # }
}
# Create the access policy for the service principal
resource "azurerm_key_vault_access_policy" "current_user_access_policy" {
  key_vault_id            = azurerm_key_vault.vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_client_config.current.object_id
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
  storage_permissions     = ["Get", "List", "Set"]
}
