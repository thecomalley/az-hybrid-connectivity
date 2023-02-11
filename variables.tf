variable "tailscale_authkey" {
  type        = string
  description = "Tailscale authkey"
  default = ""
}

variable "admin_username" {
  type        = string
  description = "Admin username"
  default = ""
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}