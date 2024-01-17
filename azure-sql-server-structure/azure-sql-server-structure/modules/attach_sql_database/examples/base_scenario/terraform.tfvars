config = {
  client = {
    subscription_id = ""
    tenant_id       = ""
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

  sql_server_attach_sql_database = {
    database1 : {
      name                = "testdatabase-1"
      resource_group_name = "databaseRG1"
      location            = "southcentralus"
      server_name         = "dbserver-1"
      version             = "12.0"
      administrator_login = "adminuser2"

    }
  }
 }
