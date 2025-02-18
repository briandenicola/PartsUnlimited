resource "azurerm_mssql_server" "this" {
  name                         = local.sql_name
  resource_group_name          = data.azurerm_resource_group.this.name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "manager"
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"
  
  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = data.azurerm_client_config.current.object_id
  }

}

resource "azurerm_mssql_database" "this" {
  name                = "PartsUnlimited"
  server_id           = azurerm_mssql_server.this.id
}

resource "azurerm_mssql_firewall_rule" "home" {
  name             = "AllowHomeNetwork"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = local.ip_address
  end_ip_address   = local.ip_address
}

# resource "azurerm_mssql_firewall_rule" "aks" {
#   name             = "AKS"
#   server_id        = azurerm_mssql_server.this.id
#   start_ip_address = data.azurerm_public_ip.aks.ip_address
#   end_ip_address   = data.azurerm_public_ip.aks.ip_address
# }