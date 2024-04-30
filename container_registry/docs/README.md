# Azure Container Registry Module
 
## Purpose
 
This Terraform module is designed to automate the creation and configuration of Azure Container Registry with best practices.
 
## Discussion and Outcomes
Discussed the choice between the different ACR Tier: Standard tier may be sufficient for basic image storage and management needs, while the Premium tier offers advance features for high-performance and security-conscious environments.

 
## Decisions
  
- **Data Protection**: Microsoft Defender for Cloud is enabled to detect vulnerabilities and security issues within Azure Container Registry. 
 
## Requirements
 
- Azure subscription and necessary permissions to create and manage Azure Container Registry.
- Terraform 0.14.x or later.
- AzureRM provider 2.46.x or later.
 
## Assumptions
 
- Users have basic knowledge of Terraform and Azure services.
- The organization's security and compliance policies are known and have been considered in the module's design.
 
## Pending Decisions
 
## References 
N/A
