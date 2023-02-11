resource "azurerm_private_dns_resolver" "hub" {
  name                = "${var.prefix}-hub-pdnsr"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  virtual_network_id  = azurerm_virtual_network.hub.id
  tags = {
    git_commit           = "6999ea2ef34a1fa618b7dac872a12d70e49d951a"
    git_file             = "modules/native-hub/dns.tf"
    git_last_modified_at = "2023-02-11 09:58:42"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "c8d9cb56-23f8-4a2d-bf8e-f2ca792af37b"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "PrivateDnsResolver"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.0.0/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "example" {
  name                    = "example-drie"
  private_dns_resolver_id = azurerm_private_dns_resolver.example.id
  location                = azurerm_private_dns_resolver.example.location
  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.example.id
  }
  tags = {
    key                  = "value"
    git_commit           = "427921f0c6effe612a31063890a5c07c268e82d0"
    git_file             = "modules/native-hub/dns.tf"
    git_last_modified_at = "2023-02-11 09:27:08"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "ca6f8003-7dd0-468b-a39b-b5f21423ee6e"
  }
}