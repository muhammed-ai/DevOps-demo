output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet.id
}
output "vnet_name" {
  description = "The name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}
output "vnet_rg" {
  description = "The name of the resource group where the vNet is created"
  value       = azurerm_virtual_network.vnet.resource_group_name
}
output "vnet_subnets" {
  description = "The ids of subnets created inside the newly vNet"
  value       = keys(azurerm_subnet.subnets)
}

