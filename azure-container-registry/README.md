
<!-- BEGIN_TF_DOCS -->
# azure-container-registry
## Module Objective
Azure Container Registry (ACR) allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. This Terraform module aims to simplify the creation and management of ACR in Azure. With ACR, you can securely manage and serve container images, integrate with existing container development and deployment pipelines, and streamline the process of bringing container-based applications to production.
## Module Config Usage
```hcl
 container_registry_base = {
   example_acr = {
     name                 = "exampleregistry1"
     location             = "South Central US"
     resource_group_name  = "plat-sandbox-keyvault-rg-1"
     sku                  = "Premium"
     identity_name        = "example_identity"
     encryption = {
       enable               = true
       kv_key_id            = "https://plat-sandbox-keyvault-7.vault.azure.net/keys/dev1"
     }
     replications = {
       sea = {
         location                  = "South Central US"
         zone_redundancy_enabled   = true
         regional_endpoint_enabled = true
       },
       eus = {
         location                  = "South Central US"
         zone_redundancy_enabled   = true
         regional_endpoint_enabled = true
       }
     }
   }
 }
```
## Other BNSF Related Module
* [Azure Container Registry documentation (Azure Documentation)](https://docs.microsoft.com/en-us/azure/container-registry/)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base"></a> [base](#module\_base) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git | develop |
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_naming | develop |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_tags | develop |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_user_assigned_identity.instance_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | The variable from locals.client\_config | <pre>object({<br>    subscription_id = string<br>    tenant_id       = string<br>  })</pre> | n/a | yes |
| <a name="input_container_registry_base"></a> [container\_registry\_base](#input\_container\_registry\_base) | n/a | <pre>map(object({<br>    name                = optional(string)<br>    location            = string<br>    resource_group_name = string<br>    vault               = string<br>    sku                 = string<br>    identity_name       = string<br>    encryption = object({<br>      enable                = optional(bool)<br>      kv_key_id             = string<br>    })<br><br>    replications = object({<br>      sea = object({<br>        location                  = string<br>        zone_redundancy_enabled   = optional(bool)<br>        regional_endpoint_enabled = optional(bool)<br>      })<br>      eus = object({<br>        location                  = string<br>        zone_redundancy_enabled   = optional(bool)<br>        regional_endpoint_enabled = optional(bool)<br>      })<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_entity_config"></a> [entity\_config](#input\_entity\_config) | The variable from entity\_config | <pre>object({<br>    team_name = string<br>    app_name  = string<br>    env_name  = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The variable for tags configuration | <pre>object({<br>    optional = optional(object({<br>      cost_center     = optional(string)<br>      project_name    = optional(string)<br>      department_name = optional(string)<br>      owner           = optional(string)<br>    }))<br>    extra = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | Details of the container registry |
<!-- END_TF_DOCS -->