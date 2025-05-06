# Create Front Door profile
resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tags                = var.tags
}

# Create Front Door endpoint
resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                     = var.endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

# Define origin group with load balancing and health check
resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  name                     = "aks-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    protocol             = "Https"
    path                 = "/healthz"  # Adjust to match your app's health check path
    request_type         = "GET"
    interval_in_seconds  = 240
  }
}

# Define the origin (AKS Ingress or LoadBalancer)
resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  name                            = "aks-ingress"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.fd_origin_group.id
  host_name                       = var.backend_hostname
  origin_host_header              = var.backend_hostname
  http_port                       = 80
  https_port                      = 443
  enabled                         = true
  priority                        = 1
  weight                          = 1000
  certificate_name_check_enabled  = true
}

# Route incoming traffic to AKS origin group
resource "azurerm_cdn_frontdoor_route" "fd_route" {
  name                             = "aks-route"
  cdn_frontdoor_endpoint_id        = azurerm_cdn_frontdoor_endpoint.fd_endpoint.id
  cdn_frontdoor_origin_group_id    = azurerm_cdn_frontdoor_origin_group.fd_origin_group.id
  cdn_frontdoor_origin_ids         = [azurerm_cdn_frontdoor_origin.fd_origin.id]

  patterns_to_match                = ["/*"]
  supported_protocols              = ["Https"]
  forwarding_protocol              = "MatchRequest"
  https_redirect_enabled           = true
  link_to_default_domain           = true
}
