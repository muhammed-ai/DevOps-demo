output "vm_id" {
  value = azurerm_linux_virtual_machine.linux_vm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.linux_vm.name
}

output "vm_resource_group_name" {
  value = azurerm_linux_virtual_machine.linux_vm.resource_group_name
}

output "vm_ipaddr" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "vm_location" {
  value = azurerm_linux_virtual_machine.linux_vm.location
}

output "vm_avzone" {
  value = azurerm_linux_virtual_machine.linux_vm.zone
}

output "vm_vnet" {
  value = data.azurerm_virtual_network.vnet.id
}

output "vm_identity" {
  value = azurerm_linux_virtual_machine.linux_vm.identity
}
