module "naming" {
  source = "../naming"
  suffix = [var.module_config.project, var.module_config.environment]
  prefix = [var.module_config.k8s_config.name_prefix]
}

resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name_unique
  location = local.default_location
  tags     = local.module_tags
  lifecycle {
    ignore_changes = [
      tags["CreationDate"]
    ]
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = module.naming.kubernetes_cluster.name_unique
  location                = local.default_location
  resource_group_name     = azurerm_resource_group.rg.name
  kubernetes_version      = "1.28.5"
  dns_prefix              = "${var.module_config.project}-${var.module_config.environment}-k8s"
  private_cluster_enabled = true
  private_dns_zone_id     = data.azurerm_private_dns_zone.priv_dns_zone.id

  default_node_pool {
    name                = "pool1"
    node_count          = var.module_config.k8s_config.node_count
    vm_size             = "Standard_D4_v5"
    os_disk_size_gb     = 30
    max_pods            = 50
    type                = "VirtualMachineScaleSets"
    zones               = [1]
    enable_auto_scaling = true
    min_count           = var.module_config.k8s_config.min_node_count
    max_count           = var.module_config.k8s_config.max_node_count
    vnet_subnet_id      = data.azurerm_subnet.subnet.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }

  network_profile {
    service_cidr      = "10.250.0.0/16"
    pod_cidr          = "10.196.0.0/14"
    dns_service_ip    = "10.250.0.10"
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  role_based_access_control_enabled = true

  tags = local.module_tags
  lifecycle {
    ignore_changes = [
      tags["CreationDate"],
      default_node_pool["upgrade_settings"]
    ]
  }
  depends_on = [azurerm_role_assignment.route-table-edit, azurerm_role_assignment.networkjoin]
}

resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = "kubeconfig"

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
