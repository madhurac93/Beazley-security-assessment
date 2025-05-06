data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  public_network_access_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }

  tags = var.tags
}


resource "azurerm_key_vault_secret" "db_password" {
  name         = var.secret_name
  value        = var.db_password
  key_vault_id = azurerm_key_vault.kv.id
}
