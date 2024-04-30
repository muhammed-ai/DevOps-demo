# Azure Virtual Network Terraform Module

This module is designed to create the BNSF Virtual Network in the Azure Environment, facilitating the deployment of a secure, scalable, and highly available virtual network infrastructure.

## Example Usage

```hcl
module "network" {
  source = "../"
  providers = { azurerm.dns = azurerm.dns}

  # Pass the required parameters to the module
  module_config = {
    project     = "cloudops"
    environment = "nonprod"
    # Setup the network configuration
    network_config = {
      cidr = "10.0.0.0/16"
      subnets = [
        {
          name = "private-1"
          cidr = "10.0.1.0/24"
        },
        {
          name = "private-2"
          cidr = "10.0.2.0/24"
          delegations = [
            {
              name         = "delegation1"
              service_name = "Microsoft.Netapp/volumes"
              actions      = []
            }
          ]
        }
      ]
    }

    # Pass the additional tags to the module
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
```
## Features Supported

- Ability to create the VNet based on the CIDR range.
- Ability to create 2 subnets as Private1-Subnet & Private2-subnet.
- Ability to link to Azure DNS Private Resolver DNS Forwarding Ruleset
- Ability to support delegation for the subnets

## Features Planned

This section would describe the enhancements or new features that are intended to be developed and added to the module in the future:
- Support for advanced networking features like Azure Bastion for secure RDP and SSH access.
- Integration with Azure Private Link to securely access Azure Services privately.
- Automatic peering with other VNets in the same or different Azure subscriptions.
- Enhanced network security features, such as improved NSG rules management or integration with Azure Firewall Manager.
- Support for new Azure regions or new capabilities released by Azure or Terraform.
- Network security group (NSG) assignment to subnets.
- Routing table configuration.
- Integration with other Azure services like Azure Firewall or VPN Gateway.

Disclaimer: We still have pending discussion with the Network Engineering team on the Enhancements or new features.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |
| <a name="provider_azurerm.dns"></a> [azurerm.dns](#provider\_azurerm.dns) | >= 3.11, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver_virtual_network_link.dns_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.dns_ruleset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_resolver_dns_forwarding_ruleset) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | Base configuration for virtual network | <pre>object({<br>    # For creating the virtual network<br>    network_config = object({<br>      cidr    = string<br>      subnets = list(object({<br>        name        = string<br>        cidr        = string<br>        delegations = optional(list(object({<br>          name         = string<br>          service_name = string<br>          actions      = list(string)<br>        })))<br>      })<br>    )})<br><br>    # For naming conventions<br>    project     = string<br>    environment = string<br><br>    # For governance purpose<br>    additional_tags = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the newly created vNet |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the newly created vNet |
| <a name="output_vnet_rg"></a> [vnet\_rg](#output\_vnet\_rg) | The name of the resource group where the vNet is created |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets) | The ids of subnets created inside the newly vNet |
<!-- END_TF_DOCS -->