config = {
  client = {
    subscription_id = "306eb98e-26d5-4606-b5bc-c57350db64b8"
    tenant_id       = "0e1609b0-5e7f-4722-8611-c7f3067cebdc"
  }

  entity = {
    team_name = "test"
    app_name  = "nic-app"
    env_name  = "dev"
  }

  tags = {
    optional = {
      cost_center     = "12345"
      owner           = "me"
      project_name    = "test-demo-project"
      department_name = "Test department"
      runtime         = "dotnet"
    }
    extra = { "Extra" = "test again" }
  }
}

sql_server_base = {
  sqlserver1 = {
    name                = "dbserver-max-1-test"
    resource_group_name = "sql-rg"
    location            = "southcentralus"
    version             = "12.0"
    administrator_login          = "adminuser"
    administrator_login_password = "Password@123"
    attach_sql_database = {
      sql-database1 : {
        name                = "sqldatabase-max-test01"
        resource_group_name = "sql-rg"
        server_name         = "dbserver-max-1-test"
        location            = "southcentralus"
        administrator_login = "adminuser"
        version             = "12.0"
      }
      sql-database2 : {
        name                = "sqldatabase-max-test02"
        resource_group_name = "sql-rg"
        server_name         = "dbserver-max-1-test"
        location            = "southcentralus"
        administrator_login = "adminuser"
        version             = "12.0"
      }
    }
  }

      sqlserver2 = {
        name                = "dbserver-max-2-test"
        resource_group_name = "sql-rg"
        location            = "southcentralus"
        version             = "12.0"
        administrator_login         = "adminuser"
        administrator_login_password = "Password@123"

        attach_sql_database = {
          sql-database3 = {
            name                = "qldatabase-max-test03"
            resource_group_name = "sql-rg"
            server_name         = "dbserver-max-2-test"
            location            = "southcentralus"
            administrator_login = "adminuser"
            version             = "12.0"
          }
          sql-database4 = {
            name                = "qldatabase-max-test104"
            resource_group_name = "sql-rg"
            server_name         = "dbserver-max-2-test"
            location            = "southcentralus"
            administrator_login = "adminuser"
            version             = "12.0"
          }
        }
      }
    }
