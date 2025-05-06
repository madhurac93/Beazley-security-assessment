
output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet"
  value       = azurerm_subnet.aks.id
}

output "db_subnet_id" {
  description = "The ID of the DB subnet"
  value       = azurerm_subnet.db.id
}


