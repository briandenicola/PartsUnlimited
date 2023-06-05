resource "azurerm_role_assignment" "cluster_admin" {
    scope                = data.azurerm_kubernetes_cluster.this.id
    role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
    principal_id         = data.azurerm_client_config.current.object_id
    #skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_push" {
    scope                = azurerm_container_registry.this.id
    role_definition_name = "AcrPush"
    principal_id         = data.azurerm_client_config.current.object_id
    #skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_pull" {
    scope                = azurerm_container_registry.this.id
    role_definition_name = "AcrPull"
    principal_id         = data.azurerm_user_assigned_identity.aks_kubelet_identity.id
    skip_service_principal_aad_check = true
}