# network-manager

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

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_manager.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/network_manager) | resource |
| [azurerm_network_manager_connectivity_configuration.hub](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/network_manager_connectivity_configuration) | resource |
| [azurerm_network_manager_network_group.spokes](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/resources/network_manager_network_group) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.43.0/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | Virtual network id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
