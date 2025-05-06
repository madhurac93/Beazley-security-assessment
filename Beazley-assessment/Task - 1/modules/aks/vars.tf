variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

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

variable "subnet_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
