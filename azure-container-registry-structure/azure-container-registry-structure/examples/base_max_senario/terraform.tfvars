config = {
  client = {
    subscription_id = ""
    tenant_id       = ""
  }

  entity = {
    team_name = "Test"
    app_name  = "account-checker"
    env_name  = "dev"
  }
  tags = {
    optional = {
      cost_center     = "12345"
      owner           = "me"
      project_name    = "test-demo-project"
      department_name = "Test department"
    }
    extra = { "Extra" : "test again" }
  }
}

  container_registry_base = {
    example-acr : {
      name                = "platsandboxexampleacr"
      location            = "South Central Us"
      resource_group_name = "plat-sandbox-keyvault-rg-1"
      sku                 = "Premium"

      replications = {
        sea = {
          location                  = "South Central Us"
          zone_redundancy_enabled   = true
          regional_endpoint_enabled = true
        }
        eus = {
          location                  = "South Central Us"
          zone_redundancy_enabled   = true
          regional_endpoint_enabled = true
        }
      }
    }
  }

