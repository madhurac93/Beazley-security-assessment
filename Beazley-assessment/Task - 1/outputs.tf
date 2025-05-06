output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the resource group"
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "ID of the Virtual Network"
}

output "web_subnet_id" {
  value       = module.network.web_subnet_id
  description = "ID of the Web subnet"
}

output "app_subnet_id" {
  value       = module.network.app_subnet_id
  description = "ID of the Application subnet"
}

output "db_subnet_id" {
  value       = module.network.db_subnet_id
  description = "ID of the Database subnet"
}

output "web_tier_apps" {
  value       = module.web_tier.web_apps
  description = "List of Web Tier App Service names"
}

output "app_tier_apps" {
  value       = module.app_tier.app_services
  description = "List of Application Tier App Service names"
}

output "db_tier_fqdn" {
  value       = module.db_tier.db_server_fqdn
  description = "Fully qualified domain name of the database server"
}

output "db_private_endpoint_ip" {
  value       = module.db_tier.private_endpoint_ip
  description = "Private IP of the database private endpoint"
}
