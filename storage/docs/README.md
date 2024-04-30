# Azure Storage Account Module
 
## Purpose
This module is designed to to create an Azure storage account with a set of configurations, such as containers, file shares, tables, queues, network policies, lifecycle management and Azure Monitor diagnostics. The module is built with a composition pattern and uses the Terraform Azure provider.
 
## Discussion and Outcomes
From the outcome of a recent meeting on Feb 7. 3:00 PM – 3:30 PM with some team members and Wendt, Jonathan, it was decided to create a module for creating an Azure storage account with some requirements like the Azure Storage Service being the StorageV2 for standard, and some Network & Connectivity configurations. 
 
## Decisions
- **Network and Connectivity**: When creating an Azure Storage Account, it has been decided that public access WILL be disabled and only private access to be enabled. Azure network rules will be applied to allow connect to the storage account only from the the specified IP address.

- **Cost-optimization**: To optimize costs when configuring an Azure Storage Account, there will be a 7 days retention period policy in place.
The Azure Storage Account tier that will be used is Hot.
Azure Storage Account replication option such as Locally Redundant Storage (LRS) will also be the standard to be used.

- **Security and Compliance**: To ensure the security and compliance of Azure Storage Account, Network rules will be applied to restrict access to specific VNets or subnets, reducing the attack surface.
Use Azure Storage Account data at rest and data in transit will also be encrypted.
 
## Upstreams Dependency & pre-requisite
- Azure subscription and necessary permissions to create and manage Azure storage account.
- Vnet & Subnet
- Terraform 1.5.x or later.
- AzureRM provider 3.91.x or later.
 
## Assumptions
- Users have active azure  subscriptions with sufficient privileges for creating a storage account in their tenant/subscription.
- Depending on the security posture needed for a production environment, access controls for this configuration would likely be tighter.
 
## Pending Decisions


## Inputs standards and requirements of creating an Azure 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource name | Must be between 3-24 charcters(Numbers and letters only) | `string` | n/a | yes |
| resource_group_name | The name of the resource group. | `string` | n/a | yes |
| location | The location where the storage account will be created. | `string` | `"southcentralus"` | yes |
| account_tier | Should contain all Azure Storage data objets, (blobs, files, queues, tables)
for unstructured data | `string` | `"Standard"` | yes |
| account_replication_type | The replication type of the storage account. | `string` | `"LRS"` | yes |
| account_kind | The kind of the storage account. | `string` | `"StorageV2"` | yes |
| network_rule_set |required IP rules and subnet_id to create a specify private access to the storage account. | `object({ default_action = string, ip_rules = list(string), virtual_network_subnet_ids = list(string) })` | n/a | yes |
| monitoring | Enable diagnostice setting to collect resource logs and send to send to logs storage
Metrics and Activity logs are collected and stored 
automatically | 
| Cost-optimizatin | should contain all Azure Storage data objets, (blobs, files, queues, tables) | 7 days deletion retention policy
days(string) |
| tags | Tags to apply to the storage account. | `map(string)` | `{}` | no |


## References 
[Azure-Storage-account](azure-storage-account.xlsx)
