module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, var.module_config.environment]
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = module.naming.virtual_network.name
  location            = local.default_location
  address_space       = [var.module_config.network_config.cidr]
  resource_group_name = local.default_resource_group
  tags                = local.mandatory_compliance_tags

  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}

# # Create Subnets
resource "azurerm_subnet" "subnets" {  
  for_each             = { for subnet in var.module_config.network_config.subnets : subnet.name => subnet }  
  name                 = each.value.name  
  resource_group_name  = local.default_resource_group  
  virtual_network_name = azurerm_virtual_network.vnet.name  
  address_prefixes     = [each.value.cidr]
  dynamic "delegation" {  
    for_each = coalesce(each.value.delegations, [])  
    content {  
      name = delegation.value.name  
      service_delegation {  
        name    = delegation.value.service_name  
        actions = delegation.value.actions  
      }  
    }
  }
}

# Link VNet to Azure Private DNS Resolver DNS Forwarding Ruleset
resource "azurerm_private_dns_resolver_virtual_network_link" "dns_link" {
  name                      = "${module.naming.virtual_network.name}-link"
  dns_forwarding_ruleset_id = data.azurerm_private_dns_resolver_dns_forwarding_ruleset.dns_ruleset.id
  virtual_network_id        = azurerm_virtual_network.vnet.id
}
