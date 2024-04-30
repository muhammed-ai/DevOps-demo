# Azure Key Vault Terraform Module

This module is designed to create the BNSF Key Vault in the Azure Environment.

## Example Usage

```hcl
provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "foundation"
  subscription_id = "50eff175-672d-4308-9b9d-f84337f3f5d1"
  features {}
}

module "keyvault" {
  source = "../../"

   providers = {
    azurerm          = azurerm
    azurerm.foundation = azurerm.foundation
  }

  module_config = {
    project             = "cloudops"
    environment         = "nonprod"
    resource_group_name = "cloudops-nonprod-rg"
    access_ids          = ["ad128605-f62f-4d60-b08a-78ecdd08d894", "1a6f7a00-b1c4-4d5a-9704-084e990be688"]
    network_config = {
      subnet_names = ["bnsf-vm-subnet1", "bnsf-vm-subnet2"]
      vnet_name    = "bnsf-vm-network"
      vnet_rg      = "bnsf-vm"
    }
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
```
## Features Supported

- Provision Azure Key Vaults with purge protection and a 7-day soft delete for key recovery, improving data resilience.
- Set predefined access policies for managing keys, secrets, and certificates.
- Define network ACLs to control access, with a predefined bypass for AzureServices enhancing security.
- Enable diagnostic settings for monitoring and logging Key Vault operations.

## Features Planned

This section would describe the enhancements or new features that are intended to be developed and added to the module in the future:
- Support for fine-grained access control through role-based access control (RBAC), allowing granular permission assignment at the role level for better security management.
- Enhanced object management by expanding the scope of `object_ids` to include `reader_ids`, `admin_ids`, or other custom roles, enabling more flexible and tailored access control configurations.

> *Disclaimer*: We still have pending discussion with the Securtiy team on the Enhancements or new features.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |
| <a name="provider_azurerm.foundation"></a> [azurerm.foundation](#provider\_azurerm.foundation) | >= 3.11, < 4.0 |
| <a name="provider_azurerm.foundation"></a> [azurerm.foundation](#provider\_azurerm.foundation) | >= 3.11, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_monitor_diagnostic_setting.kv_diagnostic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.subnet_ids](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | Base configuration for the Key Vault module. | <pre>object({<br><br>    #resource_group<br>    resource_group_name = optional(string)<br><br>    # For access policy, object ID of a user, service principal or security group<br>    access_ids = list(string)<br><br>    # For network configuration to enable access from specific subnets<br>    network_config = object({<br>      subnet_names = list(string)<br>      vnet_name    = string<br>      vnet_rg      = string<br>    })<br><br>    # For naming<br>    project     = string<br>    environment = string<br><br>    # For governance<br>    additional_tags = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Key Vault |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | The name of the Key Vault |
| <a name="output_key_vault_resource_group"></a> [key\_vault\_resource\_group](#output\_key\_vault\_resource\_group) | The name of the Resource Group in which the Key Vault resides |
<!-- END_TF_DOCS -->