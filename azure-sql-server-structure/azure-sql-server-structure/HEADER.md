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
  
## Other BNSF Related Module
* [Azure SQL documentation (Azure Documentation)](https://learn.microsoft.com/en-us/azure/azure-sql/?view=azuresql)


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
  
## Other BNSF Related Module
* [Azure SQL documentation (Azure Documentation)](https://learn.microsoft.com/en-us/azure/azure-sql/?view=azuresql)

