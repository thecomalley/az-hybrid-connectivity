resource "azurerm_public_ip" "vpng" {
  name                = "${var.prefix}-vpng-ip"
  location            = azurerm_resource_group.vpng.location
  resource_group_name = azurerm_resource_group.vpng.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpng" {
  name                = "${var.prefix}-vpng-ip"
  location            = azurerm_resource_group.vpng.location
  resource_group_name = azurerm_resource_group.vpng.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpng.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpng.id
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]
  }
}
