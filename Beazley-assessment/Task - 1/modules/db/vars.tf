variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "db_server_name" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type      = string
  sensitive = true
}

variable "db_subnet_id" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "vnet_id" {
  type = string
}

