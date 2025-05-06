variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

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