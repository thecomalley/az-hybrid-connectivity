variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name"
}

variable "tailscale_authkey" {
  type        = string
  description = "Tailscale authkey"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}