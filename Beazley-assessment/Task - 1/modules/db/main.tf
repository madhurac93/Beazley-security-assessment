# Private DNS zone (if not managed externally)
resource "azurerm_private_dns_zone" "pg_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Link VNet to the Private DNS zone
resource "azurerm_private_dns_zone_virtual_network_link" "pg_dns_link" {
  name                  = "${var.vnet_name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pg_dns.name
  virtual_network_id    = var.vnet_id
}

# Private Endpoint for PostgreSQL
resource "azurerm_private_endpoint" "db_private_endpoint" {
  name                = "${var.db_server_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.db_subnet_id

  private_service_connection {
    name                           = "${var.db_server_name}-connection"
    private_connection_resource_id = azurerm_postgresql_flexible_server.db.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pgdnszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.pg_dns.id]
  }

  tags = var.tags
}


resource "azurerm_postgresql_flexible_server" "db" {
  name                   = var.db_server_name
  location               = var.location
  resource_group_name    = var.resource_group_name

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_login_password

  version     = "13"
  sku_name    = "B_Standard_B1ms"
  storage_mb  = 32768
  zone        = "1"

  # Private networking
  delegated_subnet_id           = var.db_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.pg_dns.id
  public_network_access_enabled = false

  tags = var.tags
}
