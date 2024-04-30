# Create a user-assigned identity
resource "azurerm_user_assigned_identity" "kvid" {
  location            = local.default_location
  name                = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-mi-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.user_assigned_identity.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}l-mi-${random_string.unique.result}" : null}")
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}
# Associate the role with the vault and the user-assigned identity
resource "azurerm_role_assignment" "kvra" {
  scope                = data.azurerm_resources.kv_data.resources[0].id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.kvid.principal_id
}
# Grant the permissions to user-assigned identity
resource "azurerm_key_vault_access_policy" "kvra_policy" {
  key_vault_id       = data.azurerm_resources.kv_data.resources[0].id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_user_assigned_identity.kvid.principal_id
  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}
# Create a key vault key that will be used for disk encryption
resource "azurerm_key_vault_key" "deskey" {
  name         = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-key-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.key_vault_key.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}l-key-${random_string.unique.result}" : null}")
  key_vault_id = data.azurerm_resources.kv_data.resources[0].id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}
