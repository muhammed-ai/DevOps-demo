output "container_registry_name" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "container_registry_sku" {
  description = "The SKU name of the container registry."
  value       = azurerm_container_registry.acr.sku
}

