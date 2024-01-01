config = {
  client = {
    subscription_id = "306eb98e-26d5-4606-b5bc-c57350db64b8"
    tenant_id       = "0e1609b0-5e7f-4722-8611-c7f3067cebdc"
  }

  entity = {
    team_name = "Test"
    app_name  = "nic-app"
    env_name  = "dev"
  }

  tags = {
    optional = {
      cost_center     = "12345"
      owner           = "me"
      project_name    = "test-demo-project"
      department_name = "Test department"
    }
    extra = { "Extra" = "test again" }
  }

  #Server 1 with 2 db
  postgresql_flexible_server_base = {
      "postgreserver1" = {
        name                = "test-server-1"
        resource_group_name = "portgres-rg"
        location            = "southcentralus"
        version             = "12"
        administrator_login          = "adminuser1"
        administrator_login_password = "Password@123",
        attach_postresql_database = {
        "portgres-database1" = {
          name                = "postres-server-1"
          resource_group_name = "DBSERVERRG1"
          server_name         = "dbserver-1"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12"
        },
        "postresql-database2" = {
          name                = "database-2"
          resource_group_name = "DBSERVER-RG1"
          server_name         = "dbserver-1"
          location            = "southcentralus"
          administrator_login         = "adminuser"
          version             = "12"
        }
      }
    }

    "server2" = {
      name                = "postres-server-2"
      resource_group_name = "postres-RG1"
      location            = "southcentralus"
      version             = "12"
      administrator_login         = "adminuser"
      administrator_password      = "Password@123",
      attach_postresql_database = {
        "postresql-database3" = {
          name                = "database-3"
          resource_group_name = "postres-RG1"
          server_name         = "dbserver-2"
          location            = "southcentralus"
          administrator_login = "adminuser"
          version             = "12"
        },
        "postresql-database4" = {
          name                = "database-4"
          resource_group_name = "postgres-RG1"
          server_name         = "dbserver-2"
          location            = "southcentralus"
          administrator_login = "adminuser"
          version             = "12"
        }
      }
    }
  }
}
