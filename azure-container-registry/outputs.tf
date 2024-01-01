output "out" {
  value = {
    for map_key, registry in var.container_registry_base :
    map_key => {
      name                       = azurerm_container_registry.instance[map_key].name
      id                         = azurerm_container_registry.instance[map_key].id
    }
  }
  description = "Details of the container registry"
  sensitive   = false
}