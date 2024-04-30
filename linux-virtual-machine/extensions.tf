# Create a guest configuration extension
resource "azurerm_virtual_machine_extension" "guest_configuration_extension" {
  name                       = "${module.naming.virtual_machine.name}-gc"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm.id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
  depends_on = [azurerm_linux_virtual_machine.linux_vm]
}
# Create an Azure Monitor extension
resource "azurerm_virtual_machine_extension" "azure_monitor_extension" {
  name                       = "${module.naming.virtual_machine.name}-am"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.22"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
  depends_on = [azurerm_linux_virtual_machine.linux_vm]
}

