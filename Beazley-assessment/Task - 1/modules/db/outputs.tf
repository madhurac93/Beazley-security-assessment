output "db_server_fqdn" {
  value       = azurerm_postgresql_flexible_server.db.fqdn
  description = "Fully qualified domain name of the Azure PostgreSQL Flexible Server"
}


output "private_endpoint_ip" {
  value       = azurerm_private_endpoint.db_private_endpoint.private_service_connection[0].private_ip_address
  description = "Private IP address of the database private endpoint"
}
