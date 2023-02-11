variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "virtual_network_id" {
  type        = string
  description = "Virtual network id"
}