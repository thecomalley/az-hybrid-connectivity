resource "azurerm_subnet" "hub" {
  name                 = "TailScaleGatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "hub" {
  name                = "${var.prefix}-hub-talescale-ip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "hub" {
  name                = "${var.prefix}-hub-talescale-nic"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hub.id
  }
}

resource "azurerm_linux_virtual_machine" "hub" {
  name                = "${var.prefix}-hub-talescale-vm"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.hub.id,
  ]

  encryption_at_host_enabled = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.prefix}-hub-talescale-vm-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "null_resource" "run_asnible_playbook" {
  triggers = {
    playbook = filemd5("tailscale.yml")
    vm       = azurerm_linux_virtual_machine.hub.id
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.admin_username} -i '${azurerm_public_ip.hub.ip_address},' tailscale.yml -e tailscale_authkey=${var.tailscale_authkey}"
  }

  depends_on = [
    azurerm_linux_virtual_machine.hub,
    azurerm_network_interface.hub,
  ]
}