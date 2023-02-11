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

variable "on_prem_cidr" {
  type        = string
  description = "CIDR for on-prem network"
}