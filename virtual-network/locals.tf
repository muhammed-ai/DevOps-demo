locals {
  default_location       = "southcentralus"
  default_resource_group = "NetworkRG" # This resource group will be created by the landing zone. 

  # https://wiki.bnsf.com/display/BW/Tagging
  mandatory_compliance_tags = {
    "Project"            = var.module_config.project
    "Environment"        = var.module_config.environment
    "CreationDate"       = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
    "SourceCodeLocation" = "https://github.bnsf.com/HY/terraform-modules-registry.git"
  }

  module_tags = merge(local.mandatory_compliance_tags, var.module_config.additional_tags)

  # DNS Subscription provider for the DNS Forwarding Ruleset configurations.
  dns_resolver_forwarding_ruleset = {
    name                = "dns-sc-forwarding-ruleset-01"
    resource_group_name = "prod-rg"
  }
}
