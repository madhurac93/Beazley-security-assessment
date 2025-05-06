
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secret" "db_password" {
  name         = var.secret_name
  key_vault_id = module.keyvault.kv_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
### VNet module
module "network" {
  source                = "./modules/network"
  resource_group_name   = var.resource_group_name
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  aks_subnet_name       = var.aks_subnet_name
  aks_subnet_prefixes   = var.aks_subnet_prefixes
  db_subnet_name        = var.db_subnet_name
  db_subnet_prefixes    = var.db_subnet_prefixes
  aks_nsg_name          = var.aks_nsg_name
  db_nsg_name           = var.db_nsg_name
  aks_subnet_cidr       = var.aks_subnet_cidr
}

## Key vault module
module "keyvault" {
  source              = "./modules/keyvault"
  kv_name             = var.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  secret_name         = var.secret_name
  tags                = var.tags
  db_password         = var.db_password
  
}

## AKS cluster module
module "aks" {
  source              = "./modules/aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  aks_cluster_name    = var.aks_cluster_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  vm_size             = var.vm_size
  subnet_id           = module.network.aks_subnet_id
  tags                = var.tags
}

## Database module
module "db" {
  source              = "./modules/db"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_id                   = var.vnet_id
  vnet_name                  = var.vnet_name
  db_server_name                = var.db_server_name   
  administrator_login      = var.administrator_login
  administrator_login_password = data.azurerm_key_vault_secret.db_password.value
  db_subnet_id = module.network.db_subnet_id       
  tags                = var.tags
}
## Frontdoor
module "frontdoor" {
  source              = "./modules/frontdoor"
  resource_group_name = var.resource_group_name
  backend_hostname    = module.aks.ingress_hostname
  profile_name        = var.fd_profile_name
  endpoint_name       = var.fd_endpoint_name
  sku_name            = var.fd_sku_name
  tags                = var.tags
}


