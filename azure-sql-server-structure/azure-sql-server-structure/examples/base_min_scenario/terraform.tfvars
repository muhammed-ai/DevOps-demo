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
      runtime         = "dotnet"
    }
    extra = { "Extra" = "test again" }
  }
}

  sql_server_base = {
    sqlserver1 : {
      name                = "test-server-1"
      resource_group_name = "sql-rg"
      location            = "southcentralus"
      version             = "12.0"
      administrator_login          = "adminuser1"
      administrator_login_password = "Password@123"
    }
  }
 