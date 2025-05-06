
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

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
  resource_group_name = var.resource_group_name
  location            = var.location
  postgres_password   = var.postgres_password
  kv_name_prefix      = var.kv_name_prefix
  secret_name         = var.secret_name
  tags                = var.tags
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
  db_name             = var.db_name
  admin_username      = var.db_admin_username
  key_vault_name      = module.keyvault.kv_name
  secret_name         = var.secret_name
  db_version          = var.db_version
  sku_name            = var.db_sku_name
  storage_mb          = var.db_storage_mb
  zone                = var.db_zone
  subnet_id           = module.network.db_subnet_id
  tags                = var.tags
}
## Frontdoor
module "frontdoor" {
  source              = "./modules/frontdoor"
  resource_group_name = var.resource_group_name
  location            = var.location
  backend_hostname    = module.aks.ingress_hostname
  profile_name        = var.fd_profile_name
  endpoint_name       = var.fd_endpoint_name
  sku_name            = var.fd_sku_name
  tags                = var.tags
}


