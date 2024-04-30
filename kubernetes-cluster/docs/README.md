# Azure Kubernetes Service (AKS) Terraform Module
## Purpose:
Purpose of this document to understand the requirement and challenges for deploying a kubernetes cluster in a BNSF azure cloud private virtual network.

## Discussions and Resolutions: 
Engaged with the Enterprise Security Team, along with Cory and Bhushan, to understand the necessary firewall outbound rules required for establishing a private cluster using a custom VNet and a predefined route table.

## Decisions Made:
 - Agreed to create a comprehensive list of the outbound rules needed for deploying a private AKS cluster in BNSF Azure private VNET and raise service now request to enable them.
 - Assigned the role of Network Contributor to a User-Assigned Identity for managing the Virtual Network and Route Table settings.
 - DNS entry after getting the private endpoint of the Kubernetes cluster.

## Requirements:
 - An active Azure subscription with the rights to create and manage a private AKS cluster.
 - Terraform version 0.14 or newer.
 - AzureRM Terraform provider version 2.46 or newer. 

## Assumptions:
 - Users have a foundational knowledge of Terraform and Azure services.
 - Users are familiar with their networking infrastructure and access management policies. 

## Pending Decision:
 - **Identity Management**: Determine whether to read an existing user-assigned identity or create a new one for integration with Terraform.

## References:
[Outbound Rules Provided by Azure](https://learn.microsoft.com/en-us/azure/aks/outbound-rules-control-egress)
