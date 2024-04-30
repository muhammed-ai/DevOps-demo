###############################################
### Create Virtual Machine Resources ##########
###############################################
# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-nic-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.network_interface.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}w-nic-${random_string.unique.result}" : null}")
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.default_location
  ip_configuration {
    name                          = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-nic-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.network_interface.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}w-vm-${random_string.unique.result}" : null}")
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }

}
# Create a disk encryption set
resource "azurerm_disk_encryption_set" "des" {
  name                = var.module_config.vm_config.name != null ? "${var.module_config.vm_config.name}-des-${random_string.unique.result}" : (var.module_config.vm_config.name_prefix == null ? "${module.naming.disk_encryption_set.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}w-des-${random_string.unique.result}" : null}")
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.default_location
  key_vault_key_id    = azurerm_key_vault_key.deskey.id
  encryption_type     = "EncryptionAtRestWithCustomerKey"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.kvid.id]
  }
  tags = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
  depends_on = [azurerm_key_vault_key.deskey, azurerm_user_assigned_identity.kvid, azurerm_key_vault_access_policy.kvra_policy]
}

# Create a windows virtual machine
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = var.module_config.vm_config.name != null ? var.module_config.vm_config.name : (var.module_config.vm_config.name_prefix == null ? "${module.naming.windows_virtual_machine.name_unique}" : "${var.module_config.vm_config.name_prefix != null ? "${local.name_prefix}w-vm-${random_string.unique.result}" : null}")
  admin_password        = azurerm_key_vault_secret.adminpasswd.value
  network_interface_ids = [azurerm_network_interface.nic.id]

  # Paramaters that can be overridden by the module caller otherwise defaults will be used
  size = local.vm_config.size
  zone = local.vm_config.availability_zone

  # Parameters that are not allowed to be overridden by the module caller
  resource_group_name        = azurerm_resource_group.rg.name
  secure_boot_enabled        = local.vm_config_defaults.secure_boot_enabled
  vtpm_enabled               = local.vm_config_defaults.vtpm_enabled
  admin_username             = local.vm_config_defaults.admin_username
  location                   = local.default_location
  encryption_at_host_enabled = local.vm_config_defaults.encryption_at_host_enabled
  source_image_id            = data.azurerm_shared_image_version.image_version.id

  # Assign the system-assigned identity to the VM
  identity {
    type         = var.module_config.vm_config.user_assigned_identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.module_config.vm_config.user_assigned_identity_ids != null ? var.module_config.vm_config.user_assigned_identity_ids : []
  }

  # Create a managed disk
  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Premium_ZRS"
    disk_encryption_set_id = azurerm_disk_encryption_set.des.id
  }

  tags = local.module_tags
  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}
