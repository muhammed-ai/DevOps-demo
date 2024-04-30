# Get the values from the data source
data "azurerm_private_dns_resolver_dns_forwarding_ruleset" "dns_ruleset" {
  provider            = azurerm.dns
  name                = local.dns_resolver_forwarding_ruleset.name
  resource_group_name = local.dns_resolver_forwarding_ruleset.resource_group_name
}