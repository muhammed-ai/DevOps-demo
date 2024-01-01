<!-- BEGIN_TF_DOCS -->
# Module Objective

When creating a Terraform module for Azure PostgreSQL Flexible Server, it's important to strike a balance between flexibility and simplicity allowing users to customize their configurations while providing sensible default and best practices. Regularly update the module to accommodate changes in Terraform provider version and incorporate new features or imrovements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_attach_postgresql_database"></a> [attach\_postgresql\_database](#module\_attach\_postgresql\_database) | ./modules/attach_postgresql_database | n/a |
| <a name="module_base"></a> [base](#module\_base) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git | develop |
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_naming | develop |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_tags | develop |

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | The variable from locals.client\_config | <pre>object({<br>    subscription_id = string<br>    tenant_id       = string<br>  })</pre> | n/a | yes |
| <a name="input_entity_config"></a> [entity\_config](#input\_entity\_config) | The variable from entity\_config | <pre>object({<br>    team_name = string<br>    app_name  = string<br>    env_name  = string<br>  })</pre> | n/a | yes |
| <a name="input_postgresql_flexible_server_base"></a> [postgresql\_flexible\_server\_base](#input\_postgresql\_flexible\_server\_base) | postgresql server configuration details. | <pre>map(object({<br>    name                      = optional(string)<br>    location                  = string<br>    resource_group_name       = optional(string)<br>    version                   = string<br>    administrator_login       = string<br>    administrator_password    = optional(string)<br>    sku_name                  = optional(string)<br>    backup_retention_days     = optional(number)<br>    delegate_subnet_id       = optional(string)<br>    private_dns_zone_id       = optional(string)<br>    storage_mb                = optional(number)<br>    geo_redundant_backup_enable = optional(number)<br>    source_server_id           = optional(string)<br>    maintenance_window          = optional(map(object({<br>      day_of_week              = string<br>      start_hour               = number<br>      duration                 = number<br>    })))<br>    high_availability_enabled   = optional(object({<br>      enabled                   = bool<br>      availability_zone         = string  <br>      mode                      = string<br>      }))<br>    #Authentication block<br>    authentication                  = optional(object({<br>      active_directory_auth_enable  = bool<br>      password_auth_enabled         = bool<br>      tenant_id                     = string //active directory_auth must be set to true first<br>    }))<br>      <br><br>    attach_postgresql_database = optional(map(object({<br>      name                     = optional(string)<br>      server_id                = optional(string)<br>    })))<br><br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The variable for tags configuration | <pre>object({<br>    optional = optional(object({<br>      cost_center     = optional(string)<br>      project_name    = optional(string)<br>      department_name = optional(string)<br>      owner           = optional(string)<br>    }))<br>    extra = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | The output from azuure postgresql server |f

### Other BNSF Related Modules
* [BNSF Azure SQL Server](https://github.bnsf.com/HY/azure-sql-server/tree/develop)
<!-- END_TF_DOCS -->