variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "postgres_password" {
  type      = string
  sensitive = true
}

variable "kv_name_prefix" {
  type        = string
  description = "Prefix for Key Vault name"
  default     = "kv-pg"
}

variable "secret_name" {
  type        = string
  description = "Name of the secret to store in Key Vault"
  default     = "postgres-password"
}

variable "tags" {
  type    = map(string)
  default = {}
}
