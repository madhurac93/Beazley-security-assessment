output "frontdoor_profile_id" {
  description = "The ID of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.fd_profile.id
}

output "frontdoor_endpoint_name" {
  description = "Name of the Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.fd_endpoint.name
}

output "frontdoor_url" {
  description = "Public URL of the Front Door endpoint"
  value       = "${azurerm_cdn_frontdoor_endpoint.fd_endpoint.name}.azurefd.net"
}
