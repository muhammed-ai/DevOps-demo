# Azure Key Vault Terraform Module
 
## Purpose
 
This Terraform module is designed to automate the creation and configuration of Azure Key Vault resources in alignment with the specifications provided in the "Usage_Posture_Template-KeyVault.xlsx". It facilitates secure storage, access, and management of keys, secrets, and certificates, with a focus on compliance, security, and operational efficiency.
 
## Discussion and Outcomes
 
In our recent meeting (held on 9th February with Peter, Nilesh, Bhushan, and Richard), the team reviewed the requirements from the provided Excel template and discussed various aspects of Key Vault configuration, focusing on identity management, backup, and recovery features. The outcomes led to specific decisions on role assignments and data protection capabilities.
 
## Decisions
 
- **Identity Management**: We decided to use Azure Key Vault administration and reader roles for identity and access management. This ensures that appropriate permissions are set for users interacting with the Key Vault, enhancing security and compliance.
  
- **Data Protection**: Enable purge protection and soft delete features for Key Vault to support robust backup and recovery strategies. This decision aligns with best practices for data protection and compliance requirements.
 
## Requirements
 
- Azure subscription and necessary permissions to create and manage Azure Key Vault resources.
- Terraform 0.14.x or later.
- AzureRM provider 2.46.x or later.
 
## Assumptions
 
- Users have basic knowledge of Terraform and Azure services.
- The organization's security and compliance policies are known and have been considered in the module's design.
- Networking infrastructure and access management policies are in place and understood by the users of the module.
 
## Pending Decisions
 
- **Data High Availability (HA)**: A decision on how to ensure high availability for data stored in the Key Vault is pending. Options under consideration include replication strategies and geographic distribution.
 
## References 
[Usage Posture Template](Usage_Posture_Template-KeyVault.xlsx)
