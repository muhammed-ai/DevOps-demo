# azure-container-registry
## Module Objective
Azure Container Registry (ACR) allows you to build, store, and manage container images and artifacts in a private registry for all types of container deployments. This Terraform module aims to simplify the creation and management of ACR in Azure. With ACR, you can securely manage and serve container images, integrate with existing container development and deployment pipelines, and streamline the process of bringing container-based applications to production.
## Module Config Usage
```hcl
 container_registry_base = {
   example_acr = {
     name                 = "exampleregistry1"
     location             = "South Central US"
     resource_group_name  = "plat-sandbox-keyvault-rg-1"
     sku                  = "Premium"
     identity_name        = "example_identity"
     encryption = {
       enable               = true
       kv_key_id            = "https://plat-sandbox-keyvault-7.vault.azure.net/keys/dev1"
     }
     replications = {
       sea = {
         location                  = "South Central US"
         zone_redundancy_enabled   = true
         regional_endpoint_enabled = true
       },
       eus = {
         location                  = "South Central US"
         zone_redundancy_enabled   = true
         regional_endpoint_enabled = true
       }
     }
   }
 }
```
## Other BNSF Related Module
* [Azure Container Registry documentation (Azure Documentation)](https://docs.microsoft.com/en-us/azure/container-registry/)
