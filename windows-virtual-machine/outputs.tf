output "vm_id" {
  value = azurerm_windows_virtual_machine.windows_vm.id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.windows_vm.name
}

output "vm_resource_group_name" {
  value = azurerm_windows_virtual_machine.windows_vm.resource_group_name
}

output "vm_ipaddr" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "vm_location" {
  value = azurerm_windows_virtual_machine.windows_vm.location
}

output "vm_avzone" {
  value = azurerm_windows_virtual_machine.windows_vm.zone
}

output "vm_vnet" {
  value = data.azurerm_virtual_network.vnet.id
}

output "vm_identity" {
  value = azurerm_windows_virtual_machine.windows_vm.identity
}
