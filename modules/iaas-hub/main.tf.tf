resource "azurerm_subnet" "hub" {
  name                 = "CustomGatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "hub" {
  name                = "${var.prefix}-hub-talescale-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  tags = {
    git_commit           = "6999ea2ef34a1fa618b7dac872a12d70e49d951a"
    git_file             = "modules/iaas-hub/main.tf.tf"
    git_last_modified_at = "2023-02-11 09:58:42"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "edc06af8-832b-4671-b82f-12d5e54b543b"
  }
}

resource "azurerm_network_interface" "hub" {
  name                = "${var.prefix}-hub-talescale-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hub.id
  }
  tags = {
    git_commit           = "6999ea2ef34a1fa618b7dac872a12d70e49d951a"
    git_file             = "modules/iaas-hub/main.tf.tf"
    git_last_modified_at = "2023-02-11 09:58:42"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "7c1f6788-04a4-4d5a-8994-82b371d7da3e"
  }
}

# get the current IP
data "http" "current_ip" {
  url = "https://api.ipify.org?format=text"
}

## NSG that allows SSH only from the current IP
resource "azurerm_network_security_group" "hub" {
  name                = "${var.prefix}-hub-talescale-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = data.http.current_ip.response_body
    destination_address_prefix = "*"
  }
  tags = {
    git_commit           = "N/A"
    git_file             = "modules/iaas-hub/main.tf.tf"
    git_last_modified_at = "2023-02-11 23:55:20"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "f29db0a5-1f41-4042-9213-49f3f43a8539"
  }
}

resource "azurerm_linux_virtual_machine" "hub" {
  name                = "${var.prefix}-hub-talescale-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
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
  tags = {
    git_commit           = "6999ea2ef34a1fa618b7dac872a12d70e49d951a"
    git_file             = "modules/iaas-hub/main.tf.tf"
    git_last_modified_at = "2023-02-11 09:58:42"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "az-hybrid-connectivity"
    yor_trace            = "8d7252d4-c8eb-441e-9f4a-4a98da388479"
  }
}

resource "null_resource" "bind_playbook" {
  triggers = {
    playbook = filemd5("${path.module}/bind9.yml")
    vm       = azurerm_linux_virtual_machine.hub.id
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.admin_username} -i '${azurerm_public_ip.hub.ip_address},' ${path.module}/bind9.yml"
  }

  depends_on = [
    azurerm_linux_virtual_machine.hub,
    azurerm_network_interface.hub,
  ]
}

resource "null_resource" "tailscale_playbook" {
  triggers = {
    playbook = filemd5("${path.module}/tailscale.yml")
    vm       = azurerm_linux_virtual_machine.hub.id
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.admin_username} -i '${azurerm_public_ip.hub.ip_address},' ${path.module}/tailscale.yml -e tailscale_authkey=${var.tailscale_authkey}"
  }

  depends_on = [
    azurerm_linux_virtual_machine.hub,
    azurerm_network_interface.hub,
    null_resource.bind_playbook,
  ]
}