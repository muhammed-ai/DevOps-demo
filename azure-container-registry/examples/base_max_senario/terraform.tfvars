config = {
  client = {
    subscription_id = "306eb98e-26d5-4606-b5bc-c57350db64b8"
    tenant_id       = "0e1609b0-5e7f-4722-8611-c7f3067cebdc"
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

