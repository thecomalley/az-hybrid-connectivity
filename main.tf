provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hub" {
  name     = "${var.prefix}-hub-rg"
  location = "Australia East"
}

resource "azurerm_virtual_network" "hub" {
  name                = "${var.prefix}-hub-network"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}

module "network_manager" {
  source = "./modules/network-manager"
}

module "iaas_hub" {
  source = "./modules/iaas-hub"

  hub_vnet_id         = azurerm_virtual_network.hub.id
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location

  tailscale_authkey   = var.tailscale_authkey
  admin_username      = var.admin_username
}

# module "native_hub" {
#   source = "./modules/native-hub"

#   prefix              = var.prefix

#   hub_vnet_id         = azurerm_virtual_network.hub.id
#   resource_group_name = azurerm_resource_group.hub.name
#   location            = azurerm_resource_group.hub.location
# }