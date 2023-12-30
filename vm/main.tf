provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "nginx-interface" {
  name                = "nginx-interface"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/f01c6899-bd3a-482f-b11b-94e6500c82e7/resourceGroups/DemoRG-1/providers/Microsoft.Network/virtualNetworks/vnet-1/subnets/subnet1"
    private_ip_address_allocation = "Dynamic"
    publick_ipublic_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "nginxVM" {
  name                = "nginxVM"
  resource_group_name = var.resource_group
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "superuser"
  network_interface_ids = [
    azurerm_network_interface.nginx-interface.id,
  ]

  admin_ssh_key {
    username   = "superuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}