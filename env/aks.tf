data "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_user_assigned_identity" "aks_kubelet_identity" {
  name                = "${local.aks_name}-kubelet-identity"
  resource_group_name = data.azurerm_resource_group.this.name
}
