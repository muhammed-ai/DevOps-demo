output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.vault.id
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.vault.name
}

output "key_vault_resource_group" {
  description = "The name of the Resource Group in which the Key Vault resides"
  value       = azurerm_key_vault.vault.resource_group_name
}
