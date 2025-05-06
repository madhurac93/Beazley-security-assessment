# Global Settings
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

## Vnet
variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_prefixes" {
  type = list(string)
}

variable "db_subnet_name" {
  type = string
}

variable "db_subnet_prefixes" {
  type = list(string)
}

variable "aks_nsg_name" {
  type = string
}

variable "db_nsg_name" {
  type = string
}

variable "aks_subnet_cidr" {
  type = string
}

## Key Vault
variable "postgres_password" {
  type      = string
  sensitive = true
}

variable "kv_name_prefix" {
  type    = string
  default = "kv-pg"
}

variable "secret_name" {
  type    = string
  default = "postgres-password"
}

## AKS
variable "aks_cluster_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "node_count" {
  type    = number
  default = 2
}

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

## PostgresDb
variable "db_name" {
  type = string
}

variable "db_admin_username" {
  type = string
}

variable "db_version" {
  type    = string
  default = "13"
}

variable "db_sku_name" {
  type    = string
  default = "Standard_B1ms"
}

variable "db_storage_mb" {
  type    = number
  default = 32768
}

variable "db_zone" {
  type    = string
  default = "1"
}

## Frontdoor
variable "fd_profile_name" {
  type    = string
  default = "fd-profile"
}

variable "fd_endpoint_name" {
  type    = string
  default = "fd-endpoint"
}

variable "fd_sku_name" {
  type    = string
  default = "Standard_AzureFrontDoor"
}
