# Create a guest configuration extension
resource "azurerm_virtual_machine_extension" "guest_configuration_extension" {
  name                       = "${module.naming.virtual_machine.name}-gc"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm.id
  publisher                  = "Microsoft.GuestConfiguration"
  type                       = "ConfigurationforWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
  depends_on = [azurerm_windows_virtual_machine.windows_vm]
}
# Create an Azure Monitor extension
resource "azurerm_virtual_machine_extension" "azure_monitor_extension" {
  name                       = "${module.naming.virtual_machine.name}-am"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
  depends_on = [azurerm_windows_virtual_machine.windows_vm]
}

