variable "resource_group_name" {
  type        = string
  description = "Resource group in which the Front Door resources will be created"
}

variable "profile_name" {
  type        = string
  description = "Name of the Azure Front Door profile"
}

variable "endpoint_name" {
  type        = string
  description = "Name of the Front Door endpoint"
}

variable "sku_name" {
  type        = string
  description = "SKU tier for Azure Front Door"
  default     = "Standard_AzureFrontDoor"
}

variable "backend_hostname" {
  type        = string
  description = "Host name of the backend (e.g., AKS ingress or LoadBalancer DNS)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to Front Door resources"
  default     = {}
}
