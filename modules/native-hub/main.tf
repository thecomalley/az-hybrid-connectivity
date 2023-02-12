resource "azurerm_public_ip" "vpng" {
  name                = "${var.prefix}-vpng-ip"
  location            = azurerm_resource_group.vpng.location
  resource_group_name = azurerm_resource_group.vpng.name

  allocation_method = "Dynamic"
  tags = {
    git_commit           = "427921f0c6effe612a31063890a5c07c268e82d0"
    git_file             = "modules/native-hub/main.tf"
    git_last_modified_at = "2023-02-11 09:27:08"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "598871de-18c7-4dc3-9373-6b7691025ff4"
  }
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
  tags = {
    git_commit           = "7eea79ce269eefe0e6300b3f16dc8f8721655611"
    git_file             = "modules/native-hub/main.tf"
    git_last_modified_at = "2023-02-11 23:57:31"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "63ce6143-e4f9-43b7-8cea-49f716069899"
  }
}
