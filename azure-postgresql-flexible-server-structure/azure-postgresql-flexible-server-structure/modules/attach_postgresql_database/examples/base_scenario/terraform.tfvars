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
    }
    extra = { "Extra" = "test again" }
  }

  postgresql_flexible_server_attach_postgresql_database = {
    "postgres-database1" = {
      name                = "testdatabase-1"
      resource_group_name = "databaseRG1"
      location            = "southcentralus"
      server_id           = "postgres-serverid"

      version             = "12"
      administrator_login = "adminuser001"

    }
  }
 }
