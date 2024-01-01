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
  postgresql_flexible_server_base = {
    postgreserver1 : {
      name                = "myflexibletestserver"
      resource_group_name = "postgres-rg"
      location            = "southcentralus"
      version             = "12"
      administrator_login = "adminuser1"
      administrator_password = "Password@123"
      sku_name                 = "GP_Standard_D4s_v3"
      storage_mb              = "32768"
      backup_retention_days         = 30
      maintenance_window           = {
        day_of_Week              = "Monday"
        start_hour               = "1.00:00"
        duration                 = "3.00:00"
      }
      
    postgreserver : {
      resource_group_name = "postgres-rg"
      location            = "southcentralus"
      version             = "12"
      administrator_login             = "adminuser2"
      administrator_login_password    = "Password@123"
      sku_name                 = "GP_Standard_D4s_v3"
      storage_mb              = "32768"
      backup_retention_days         = 30
    }
   }
 }