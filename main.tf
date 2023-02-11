provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hub" {
  name     = "${var.prefix}-hub-rg"
  location = "Australia East"
  tags = {
    git_commit           = "427921f0c6effe612a31063890a5c07c268e82d0"
    git_file             = "main.tf"
    git_last_modified_at = "2023-02-11 09:27:08"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "533d96e1-59a6-4c6d-b02e-1f27baa2dd78"
  }
}

resource "azurerm_virtual_network" "hub" {
  name                = "${var.prefix}-hub-network"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  tags = {
    git_commit           = "427921f0c6effe612a31063890a5c07c268e82d0"
    git_file             = "main.tf"
    git_last_modified_at = "2023-02-11 09:27:08"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "7012ab75-d8c6-4a6d-8d9a-3dcc6b889894"
  }
}

resource "azurerm_private_dns_zone" "privatelink" {
  name                = "vms.privatelink.azure"
  resource_group_name = azurerm_resource_group.hub.name
  tags = {
    yor_trace = "62492671-7209-4c42-9e66-768e4e289dd7"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  name                  = "vms"
  resource_group_name   = azurerm_resource_group.hub.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = true
  tags = {
    git_commit           = "N/A"
    git_file             = "main.tf"
    git_last_modified_at = "2023-02-11 23:55:18"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "aab57b24-bdbb-40e9-add4-74278257e671"
  }
}

module "network_manager" {
  source = "./modules/network-manager"

  prefix              = var.prefix
  virtual_network_id  = azurerm_virtual_network.hub.id
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
}

module "iaas_hub" {
  source = "./modules/iaas-hub"

  prefix               = var.prefix
  virtual_network_name = azurerm_virtual_network.hub.name
  resource_group_name  = azurerm_resource_group.hub.name
  location             = azurerm_resource_group.hub.location

  tailscale_authkey = var.tailscale_authkey
  admin_username    = var.admin_username
}

# module "native_hub" {
#   source = "./modules/native-hub"

#   prefix              = var.prefix

#   hub_vnet_id         = azurerm_virtual_network.hub.id
#   resource_group_name = azurerm_resource_group.hub.name
#   location            = azurerm_resource_group.hub.location
# }