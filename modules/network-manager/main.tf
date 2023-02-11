data "azurerm_subscription" "current" {
}

resource "azurerm_network_manager" "hub" {
  name                = "${var.prefix}-hub-network-manager"
  location            = var.location
  resource_group_name = var.resource_group_name
  scope {
    subscription_ids = [data.azurerm_subscription.current.id]
  }
  scope_accesses = ["Connectivity", "SecurityAdmin"]
  description    = "hub network manager"
  tags = {
    git_commit           = "6999ea2ef34a1fa618b7dac872a12d70e49d951a"
    git_file             = "modules/network-manager/main.tf"
    git_last_modified_at = "2023-02-11 09:58:42"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "8b187eb7-f436-48a6-bdc7-809bd8c71cac"
  }
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
    resource_id   = var.virtual_network_id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

