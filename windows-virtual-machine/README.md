# Azure Windows Virtual Machine Terraform Module

This module is designed to create the BNSF Windows Virtual Machine in the Azure Environment, facilitating the deployment of a secure, scalable, and highly available virtual machine infrastructure.

## Example Usage For Windows Virtual Machine

```hcl
module "vm" {
  source    = "../../"
  providers = { azurerm.foundation = azurerm.foundation }
  module_config = {
    # Mandatory governance parameters
    project     = "cloudops"
    environment = "nonprod"

    # Mandatory VM configuration parameters
    vm_config = {
      name_prefix                = "dfwnpcloudops"
      size                       = "Standard_D2s_v3"
      user_assigned_identity_ids = ["/subscriptions/50eff175-672d-4308-9b9d-f84337f3f5d1/resourceGroups/MC_ftw-rg-cloudops-nonprod-o4im_ftw-aks-cloudops-nonprod-o4im_southcentralus/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ftw-aks-cloudops-nonprod-o4im-agentpool"]
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name   = "vnet-foundation-nonprod"
      subnet_name = "private-1"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}
```

## Features Supported

This Terraform module provides the following features:

- Create a resource group to contain all module resources.
- Create a user-assigned identity.
- Create a key for disk encryption and stored in the centralized Keyvault.
- Associate roles with the vault and user-assigned identity.
- Generate a random password for the Windows VM admin account.
- Store the random admin password in a centralized Key Vault secret.
- Create a Key Vault access policy.
- Create a network interface.
- Create virtual machines with Windows configurations.
- Create a disk encryption set.
- Create an OS disk.
- Able to assign system-assigned and user-assigned identities to the VM.
- Create a guest configuration extension.
- Create an Azure Monitor extension.

## Features Planned

This section would describe the enhancements or new features that are intended to be developed and added to the module in the future:
- Optional creation of Azure managed disks for VMs, allowing users to choose between Premium ZRS, standard HDD, standard SSD, and premium SSD disks based on performance requirements and cost considerations.
- Implementation of VM backup solutions and disaster recovery strategies to ensure data integrity and availability.

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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_disk_encryption_set.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_access_policy.kvra_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.deskey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.adminpasswd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.kvra](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.kvid](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_virtual_machine_extension.azure_monitor_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.guest_configuration_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.adminpasswd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.unique](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [terraform_data.check_variables](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resources.kv_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |
| [azurerm_shared_image_version.image_version](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/shared_image_version) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | A map of VM configuration parameters | <pre>object({<br>    # For naming conventions<br>    project             = string<br>    environment         = string<br>    resource_group_name = optional(string)<br><br>    vm_config = object({<br>      # For VM configuration<br>      name_prefix                = optional(string)<br>      name                       = optional(string)<br>      size                       = optional(string)<br>      availability_zone          = optional(string)<br>      admin_username             = optional(string)<br>      license_type               = optional(string)<br>      user_assigned_identity_ids = optional(list(string))<br>      secure_boot_enabled        = optional(bool)<br>      vtpm_enabled               = optional(bool)<br>      encryption_at_host_enabled = optional(bool)<br>      vm_shared_image_version = optional(object({<br>        name                = string<br>        image_name          = string<br>        gallery_name        = string<br>        resource_group_name = string<br>      }))<br>    })<br><br>    network_config = object({<br>      # For network configuration<br>      vnet_name   = string<br>      subnet_name = string<br>    })<br><br>    # For governance purpose<br>    additional_tags = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_avzone"></a> [vm\_avzone](#output\_vm\_avzone) | n/a |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | n/a |
| <a name="output_vm_identity"></a> [vm\_identity](#output\_vm\_identity) | n/a |
| <a name="output_vm_ipaddr"></a> [vm\_ipaddr](#output\_vm\_ipaddr) | n/a |
| <a name="output_vm_location"></a> [vm\_location](#output\_vm\_location) | n/a |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | n/a |
| <a name="output_vm_resource_group_name"></a> [vm\_resource\_group\_name](#output\_vm\_resource\_group\_name) | n/a |
| <a name="output_vm_vnet"></a> [vm\_vnet](#output\_vm\_vnet) | n/a |
<!-- END_TF_DOCS -->