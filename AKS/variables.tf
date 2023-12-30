variable "resource_group" {
    description = "The name of the resource group in which to create the virtual network."
    default = "DemoRG-1"
}
variable "location" {
    default = "Central US"
}
variable "vnet" {
    default = "vnet1"
}
variable "subnet" {
    default = "subnet1"
}

variable "cluster_name" {
  default = "Dev-Aks"
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  default = "1.28"
  description = "Kubernetes version"
}

variable "system_node_count" {
  default = "1"
  description = "Number of AKS worker nodes"
}

variable "acr_name" {
  default = "test01acr01"
  description = "ACR name"
}
variable "acr_id"{
  default = "/subscriptions/f01c6899-bd3a-482f-b11b-94e6500c82e7/resourceGroups/DemoRG-1/providers/Microsoft.ContainerRegistry/registries/test01acr01"
}
