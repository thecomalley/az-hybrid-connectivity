data "azurerm_subscription" "current" {
}

resource "azurerm_network_manager" "hub" {
  name                = "${var.prefix}-hub-network-manager"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  scope {
    subscription_ids = [data.azurerm_subscription.current.id]
  }
  scope_accesses = ["Connectivity", "SecurityAdmin"]
  description    = "hub network manager"
}

resource "azurerm_network_manager_network_group" "spokes" {
  name               = "spokes"
  description        = "All the spoke vnets"
  network_manager_id = azurerm_network_manager.hub.id
}

# TODO: Assign Policy to associate vnets with this spoke group

resource "azurerm_network_manager_connectivity_configuration" "hub" {
  name                            = "HubAndSpoke"
  network_manager_id              = azurerm_network_manager.hub.id
  connectivity_topology           = "HubAndSpoke"
  delete_existing_peering_enabled = true

  applies_to_group {
    group_connectivity = "DirectlyConnected"
    network_group_id   = azurerm_network_manager_network_group.spokes.id
  }

  hub {
    resource_id   = azurerm_virtual_network.hub.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

