resource "azurerm_user_assigned_identity" "uai" {
  location            = local.default_location
  name                = module.naming.user_assigned_identity.name_unique
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.module_tags
  lifecycle {
    ignore_changes = [
      tags["CreationDate"]
    ]
  }
}

resource "azurerm_role_assignment" "networkjoin" {
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_virtual_network.vnet.id
}

resource "azurerm_role_assignment" "route-table-edit" {
  scope                = data.azurerm_subnet.subnet.route_table_id
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
  role_definition_name = "Network Contributor"
}
resource "azurerm_role_assignment" "dnslink" {
  scope                = data.azurerm_private_dns_zone.priv_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}

resource "azurerm_role_assignment" "acr-role" {
  scope                            = data.azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}