# Overview

It's important for lab environments to simulate real world scenarios as much as possible, today we are going to look at deploying Hybrid connectivity to Azure using a couple of different options.

Both methods will allow us to:
- Access Azure resources from on-premises using a VPN tunnel
- Resolve Azure Private DNS Zones from on-premises

The above items are key for the lab environment, as it allows us develop and test on Azure Private DNS Zones, Private endpoints and Private Link Services

---

## Option 1 - Cloud Native Solution

|                 |                   |
| --------------- | ----------------- |
| Cost            | NZ$46.28 per month |
| Deployment time | 5 minutes         |

This Option is the Azure Native way of doing things, it's the easiest to setup and maintain, but it's also the most expensive. This option is best suited for production environments. or for spinning up a lab environment for a short period of time.

- Azure VPN Gateway for P2S VPN
- Azure Private DNS Resolver to resolve Private DNS Zones from on-premises

---

## Option 2 - Custom IaaS Solution

|                 |                   |
| --------------- | ----------------- |
| Cost            | NZ$24.57 per month |
| Deployment time | 5 minutes         |

This option deploys an VM to manage both the VPN tunnel and the DNS Resolver. This option is best suited for lab environments that will be running for a long period of time. This option is also the cheapest option, it can also be easily deallocated when not in use.

- Azure Virtual Machine
  - TailScale VPN Client
  - Bind9 DNS Server

---

## Bonus: Azure Network Manager (Preview)

Azure Network Manager is a new service that allows you centrally manage your network configuration. We are going to use this to create a Hub and Spoke network topology, ensuring that any new virtual networks are automatically peered to the central hub.

---

## Getting Started

1. Clone the repo
2. Create a `terraform.tfvars` file with the following variables:
    ```
    tailscale_authkey = "YOUR_TAILSCALE_AUTH_KEY"
    admin_username    = "YOUR_ADMIN_USERNAME"
    prefix            = "YOUR_PREFIX"

    ```
3. Login to Azure with `az login`
4. Run `terraform init`
5. Run `terraform apply`
6. Confirm the device has been added to your Tailscale account
7. Disassociate the Public IP from the VM
8. Delete the Public IP

Success! you now have a VPN tunnel to your Azure network. for only NZ$7.28 per month.

## Network Manager (Preview)

Manual Steps
- Deploy Policy to associate the spokes to the group
  - name does not contain `hub`
- Deploy the configuration to all regions?
- policy to associate all subnets to central route table??
