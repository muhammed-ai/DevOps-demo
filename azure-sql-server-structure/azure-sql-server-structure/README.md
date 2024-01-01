<!-- BEGIN_TF_DOCS -->
# azure-sql-server

## Module Objective
The goal of the Terraform module for Azure SQL Server is to encapsulate the infrastructure-as-code (IaC) logic required to provision and manage an Azure SQL Server instance into a reusable and modular structure. These modules would centralize the configuration parameters such as server name, resource group, and firewall rules, streamlining the process of creating and managing SQL Server instances across different environments. This modularization enhances code organization, promtes resuability, and simplifies the overall infrastructure management, aligning with Terraform's core principles of infrastruture as code and enabling efficient collabrations within the organizatin's development and operation teams.

## Module Config Usage
```hcl
#Server 1 with 2 db
sql_server_base = {
    "server1" = {
      name                = "dbserver-1"
      resource_group_name = "DBSERVERRG1"
      location            = "southcentralus"
      version             = "12.0"
      administrator_login         = "adminuser"
      administrator_login_password      = "Password@123",
      attach_sql_database = {
        "sql-database1" = {
          name                = "database-1"
          resource_group_name = "DBSERVERRG1"
          server_name         = "dbserver-1"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12.0"
        },
        "sql-database2" = {
          name                = "database-2"
          resource_group_name = "DBSERVER-RG1"
          server_name         = "dbserver-1"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12.0"
        }
      }
    }
#server 2 with 2 db
    "server2" = {
      name                = "dbserver-2"
      resource_group_name = "DBSERVER-RG1"
      location            = "southcentralus"
      version             = "12.0"
      aadministrator_login         = "adminuser"
      administrator_login_password      = "Password@123",
      attach_sql_database = {
        "sql-database3" = {
          name                = "database-3"
          resource_group_name = "DBSERVER-RG1"
          server_name         = "dbserver-2"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12.0"
        },
        "sql-database4" = {
          name                = "database-4"
          resource_group_name = "DBSERVER-RG1"
          server_name         = "dbserver-2"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12.0"
        }
      }
    }
  }
  ```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_attach_sql_database"></a> [attach\_sql\_database](#module\_attach\_sql\_database) | ./modules/attach_sql_database | n/a |
| <a name="module_base"></a> [base](#module\_base) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git | develop |
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_naming | develop |
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://github.bnsf.com/HY/azure-cloudopt-base.git//modules/base_tags | develop |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.instance_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_sql_server.instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | The variable from locals.client\_config | <pre>object({<br>    subscription_id = string<br>    tenant_id       = string<br>  })</pre> | n/a | yes |
| <a name="input_entity_config"></a> [entity\_config](#input\_entity\_config) | The variable from entity\_config | <pre>object({<br>    team_name = string<br>    app_name  = string<br>    env_name  = string<br>  })</pre> | n/a | yes |
| <a name="input_sql_server_base"></a> [sql\_server\_base](#input\_sql\_server\_base) | sql server configuration details. | <pre>map(object({<br>    name                = optional(string)<br>    location            = string<br>    resource_group_name = optional(string)<br>    version             = string<br>    administrator_login             = string<br>    administrator_login_password    = optional(string)<br>    attach_sql_database = optional(map(object({<br>      name                = optional(string)<br>      location            = string<br>      server_name         = optional(string)<br>      version             = string<br>      administrator_login = string<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The variable for tags configuration | <pre>object({<br>    optional = optional(object({<br>      cost_center     = optional(string)<br>      project_name    = optional(string)<br>      department_name = optional(string)<br>      owner           = optional(string)<br>    }))<br>    extra = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | The output from azuure sql server |

## Other BNSF Related Module
* [Azure SQL documentation (Azure Documentation)](https://learn.microsoft.com/en-us/azure/azure-sql/?view=azuresql)
<!-- END_TF_DOCS -->