data "azuread_users" "this" {
  user_principal_names = local.user_principal_names
  ignore_missing       = true
}

data "azurerm_role_definition" "this" {
  for_each = local.permissions

  name  = each.value["name"]
  scope = each.value["scope"]
}
