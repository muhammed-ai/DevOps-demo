# Azure Storage Account Terraform Module
This module creates a storage account in Azure with BNSF UPD configurations standard like disabling of public access to the storage account. It is designed to be used with the [Azure Provider](https://registry.terraform.io/providers/hashicorp/)

## Example Usage
```hcl
module "storage_account" {
  source = "../"
  module_config = {
    project     = "cloudops"
    environment = "nonprod"
    # resource_group_name = "cloudops-nonprod-rg"
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

## Feature Supported
This module supports the following features:
* Networking rule (VNet and Subnets) 
* Tags for resource groups, storage accounts, containers, blobs, files shares etc.
* Ability to create new rg when ones doesn't specify or use an existing one
* Encryption settings for resources such as Blob Containers, File Shares etc.


## Feature Planned
The following features are planned to be supported in future releases of this module:
* Diagnostic settings for logs/metrics on resources such as Blob Containers, File Shares etc.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet_ids](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | n/a | <pre>object({<br>    # Mandatory parameters to use for naming convention<br>    project     = string<br>    environment = string<br><br>    # Optional parameters to use for resource creation<br>    resource_group_name = optional(string)<br><br>    # Containes that needs to be created inside the storage account<br>    containers          = optional(list(string))<br><br>    # Mandatory parameters to use for resource creation<br>    network_config = object({<br>      subnet_names = list(string)<br>      vnet_name    = string<br>      vnet_rg      = string<br>    })<br><br>    additional_tags = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Storage account name. |
<!-- END_TF_DOCS -->