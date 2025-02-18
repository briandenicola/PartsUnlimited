output "APP_NAME" {
    value = local.resource_name
    sensitive = false
}

output "APP_RESOURCE_GROUP" {
    value = data.azurerm_resource_group.this.name
    sensitive = false
}