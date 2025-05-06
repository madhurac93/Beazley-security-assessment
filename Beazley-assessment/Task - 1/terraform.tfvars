resource_group_name  = "rg-3tier-app"
location             = "eastus"

tags = {
  environment = "dev"
  project     = "3-tier-app"
}

vnet_name           = "vnet-3tier"
vnet_address_space  = ["10.0.0.0/16"]
aks_subnet_name     = "snet-aks"
aks_subnet_prefixes = ["10.0.1.0/24"]
db_subnet_name      = "snet-db"
db_subnet_prefixes  = ["10.0.2.0/24"]
aks_nsg_name        = "nsg-aks"
db_nsg_name         = "nsg-db"
aks_subnet_cidr     = "10.0.1.0/24"
kv_name_prefix      = "kv"
secret_name         = "postgres-password"

aks_cluster_name = "aks-3tier"
dns_prefix        = "aksdemo"
node_count        = 2
vm_size           = "Standard_DS2_v2"

db_name            = "pg3tier"
db_admin_username  = "pgadmin"
db_version         = "13"
db_sku_name        = "Standard_B1ms"
db_storage_mb      = 32768
db_zone            = "1"

fd_profile_name  = "fd-3tier"
fd_endpoint_name = "fd-endpoint"
fd_sku_name      = "Standard_AzureFrontDoor"
