# iaas-hub

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.43.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.43.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/public_ip) | resource |
| [azurerm_subnet.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/subnet) | resource |
| [null_resource.bind_playbook](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [null_resource.tailscale_playbook](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [http_http.current_ip](https://registry.terraform.io/providers/hashicorp/http/2.1.0/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_tailscale_authkey"></a> [tailscale\_authkey](#input\_tailscale\_authkey) | Tailscale authkey | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Virtual network name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
