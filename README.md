# Azure Entra Group Terraform module

Terraform module which creates Azure Entra group and manage membership and assignments to Azure.

## Examples

### Create an Entra group with members only

```hcl
module "group" {
  source = "bl-solutions/entra-group/azure"

  display_name = "Team A - Developers"
  description  = "Developers of Team A"

  owners  = [ "charly@example.com" ]
  members = [
    "alice@example.com",
    "bob@example.com",
  ]
}
```

### Create an Entra group with members and assignments

```hcl
module "group" {
  source = "bl-solutions/entra-group/azure"

  display_name = "Team A - Developers"
  description  = "Developers of Team A"

  owners  = [ "charly@example.com" ]
  members = [
    "alice@example.com",
    "bob@example.com",
  ]

  assignments = {
    "Owner" = [
      "/providers/Microsoft.Management/managementgroups/bc2a76cc-ee63-4b25-bfb7-63f6585b9bd3",
    ],
    "Contributor" = [
      "/subscriptions/169e9509-301a-4506-82bc-5995ce123cc3/resourceGroups/group1"
    ]
    "Reader" = [
      "/subscriptions/3b882293-5bdc-4885-8e41-b66c2ad4cc5e",
      "/subscriptions/13009a56-57aa-4477-825e-7cf4da192fd2",
    ]
  }
}
```

## Assignments

Assignments are defined in the `assignments` input as `map(list(string))`.

Each key is the name of the role to be assigned, and the corresponding list contains all the scopes to be used.

You can use any scope allowed by the [Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment#scope-1).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_users.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignments"></a> [assignments](#input\_assignments) | (Optional) Right of the group on Azure. See Assignment section of README.md for details. | `map(list(string))` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description of the Entra Group. | `string` | `""` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The name of the Entra group. | `string` | n/a | yes |
| <a name="input_members"></a> [members](#input\_members) | (Optional) List of user principal names to add as members of the group. | `list(string)` | `[]` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | (Optional) List of user principal names to add as owners of the group. If not provided, the principal used by Terraform is used as owner of the group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The id of the group. |
<!-- END_TF_DOCS -->

## Authors

This Terraform module is maintained by [Mathieu DE SOUSA](https://github.com/bl-solutions).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bl-solutions/terraform-azure-entra-group/tree/main/LICENSE) for full details.
