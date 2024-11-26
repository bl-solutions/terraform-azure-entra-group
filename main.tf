resource "azuread_group" "this" {
  display_name = var.display_name
  description  = var.description
  owners       = local.owners
  members      = local.members

  security_enabled = true
}

resource "azurerm_role_assignment" "this" {
  for_each = local.assignments

  principal_id       = each.value["principal_id"]
  scope              = each.value["scope"]
  role_definition_id = each.value["role_definition_id"]
}
