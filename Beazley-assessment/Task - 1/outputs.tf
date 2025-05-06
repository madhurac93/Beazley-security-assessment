output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the resource group"
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "ID of the Virtual Network"
}


output "aks_subnet_id" {
  value       = module.network.aks_subnet_id
  description = "ID of the Application subnet"
}

output "db_subnet_id" {
  value       = module.network.db_subnet_id
  description = "ID of the Database subnet"
}


output "db_tier_fqdn" {
  value       = module.db.db_server_fqdn
  description = "Fully qualified domain name of the database server"
}

output "db_private_endpoint_ip" {
  value       = module.db.private_endpoint_ip
  description = "Private IP of the database private endpoint"
}
