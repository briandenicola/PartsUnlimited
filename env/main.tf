data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "http" "myip" {
  url = "https://api64.ipify.org?format=json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "random_password" "password" {
  length = 25
  special = true
}

locals {
  location      = var.region
  resource_name = var.app_name
  ip_address    = jsondecode(data.http.myip.response_body).ip
  sql_name      = "${local.resource_name}-sql"
  aks_name      = "${local.resource_name}-aks"
  acr_name      = "${replace(local.resource_name, "-", "")}acr"
}

data "azurerm_resource_group" "this" {
  name = "${local.resource_name}_rg"
}
