resource "azurerm_container_registry" "this" {
  name                     = local.acr_name
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  sku                      = "Premium"
  admin_enabled            = false

  network_rule_set {
    default_action = "Deny"
    ip_rule {
      action              = "Allow"
      ip_range            =  "${local.ip_address}/32"
    }

    ip_rule = {
        action = "Allow"
        ip_address = "${data.azurerm_public_ip.aks.ip_address}/32"
    }
  }
}