<!-- BEGIN_TF_DOCS -->
# Azure Kubernetes Services Terraform Module

This module is designed to create the BNSF Kubernetes Cluster in the Azure Environment, facilitating the deployment of a secure and scalable.

```hcl

module "k8s" {
  source    = "../"
  module_config = {
    # Mandatory governance parameters
    project     = "cloudops"
    environment = "nonprod"

    # Mandatory k8s configuration parameters
    k8s_config = {
      name_prefix = "ftw"
      node_count  = "2"
      min_node_count   = "1"
      max_node_count   = "4"
    }

    # Mandatory network configuration parameters
    network_config = {
      vnet_name        = "vnet-foundation-nonprod"
      subnet_name      = "private-1"
    }

    # Additional tags in addition to the mandatory ones
    additional_tags = {
      "Owner"      = "EnterpriseCloudOps@bnsf.com"
      "CostCenter" = "80219"
    }
  }
}

```

## Features supported
- Create a user assigned identity and assign the role of Network contributor
- Generate the kube config
- Create K8s cluster in BNSF defined virtual network
- Enable Autoscaling of nodes based on workload
- Integration with Azure Container Registry

## Features Planned
- Integration with Azure Active Directory for RBAC
- Enabling Azure Policy for Kubernetes
- Enabling Azure Monitor for containers and Azure Log Analytics

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.11, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |
| <a name="provider_azurerm.sharedservices"></a> [azurerm.sharedservices](#provider\_azurerm.sharedservices) | >= 3.11, < 4.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ../naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acr-role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dnslink](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.networkjoin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.route-table-edit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.uai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_private_dns_zone.priv_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | A map of VM configuration parameters | <pre>object({<br>    # For naming conventions<br>    project     = string<br>    environment = string<br><br>    k8s_config = object({<br>      # For k8s configuration<br>      name_prefix    = string<br>      node_count     = number<br>      min_node_count = number<br>      max_node_count = number<br>    })<br><br>    network_config = object({<br>      # For network configuration<br>      vnet_name   = string<br>      subnet_name = string<br>    })<br><br>    # For governance purpose<br>    additional_tags = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the Kubernetes cluster. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | The kube config for the created Kubernetes cluster. |
<!-- END_TF_DOCS -->

