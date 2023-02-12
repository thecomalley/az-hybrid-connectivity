# Overview

It's important for lab environments to simulate real world scenarios as much as possible, today we are going to look at deploying Hybrid connectivity to Azure using a couple of different options.

Both methods will allow us to:
- Access Azure resources from a workstation (simulating on-premises)
- Resolve Azure Private DNS Zones from on-premises

The above items are key for the lab environment, as it allows us develop and test on Azure Private DNS Zones, Private endpoints and Private Link Services

---

## Option 1 - Cloud Native Solution

| Cost            | NZ$46.28 per month |
| --------------- | ----------------- |
| Deployment time | 5 minutes         |

This Option is the Azure Native way of doing things, it's the easiest to setup and maintain, but it's also the most expensive. This option is best suited for production environments. or for spinning up a lab environment for a short period of time.

- Azure VPN Gateway for P2S VPN
- Azure Private DNS Resolver to resolve Private DNS Zones from on-premises

---

## Option 2 - Custom IaaS Solution

| Cost            | NZ$24.57 per month |
| --------------- | ----------------- |
| Deployment time | 5 minutes         |

This option deploys an VM to manage both the VPN tunnel and the DNS Resolver. This option is what i use for my Azure Lab as i can quickly allocate and de-allocate the VM without having to wait for the VPN Gateway to be provisioned.

- Azure Virtual Machine
  - TailScale VPN Client
  - Bind9 DNS Server

---

## Bonus: Azure Network Manager (Preview)

Azure Network Manager is a new service that allows you centrally manage your network configuration. We are going to use this to create a Hub and Spoke network topology, ensuring that any new virtual networks are automatically peered to the central hub.

---

## Prerequisites
- TailScale Account
- TailScale Auth Key
- 

## Getting Started

1. Clone the repo
2. Create a `terraform.tfvars` file with the following variables:
    ```
    prefix            = "naming-prefix"
    ```
3. Login to Azure with `az login`

## Option 1 - Cloud Native Solution
1. 

## Option 2 - Custom IaaS Solution
1. Change the module you want to use in `main.tf` to `custom-iaas`
2. Update `terraform.tfvars` with the following settings:
  ```yml
  tailscale_authkey = "YOUR_TAILSCALE_AUTH_KEY" 
  admin_username    = "YOUR_ADMIN_USERNAME"
  ```
3. Run `terraform init, plan & apply`
   1. Terraform will call ansible to install the required packages

### TailScale Configuration

1. Enable the Subnet routes in Tailscale
2. Add the Tailscale IP as a Custom DNS Server inside TailScale
3. Restart the Tailscale client on your workstation

### Test Connectivity

- DNS: `nslookup {vm-name}.privatelink.test {tailscale IP}` 
- Network: `ping {vm-name}.privatelink.test`


## Bonus: Azure Network Manager (Preview)

Manual Steps
- Deploy Policy to associate the spokes to the group
  - name does not contain `hub`
- Deploy the configuration to all regions?
- policy to associate all subnets to central route table??


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iaas_hub"></a> [iaas\_hub](#module\_iaas\_hub) | ./modules/iaas-hub | n/a |
| <a name="module_network_manager"></a> [network\_manager](#module\_network\_manager) | ./modules/network-manager | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.privatelink](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_tailscale_authkey"></a> [tailscale\_authkey](#input\_tailscale\_authkey) | Tailscale authkey | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->