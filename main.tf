data "azuread_client_config" "current" {}

data "azuread_users" "this" {
  user_principal_names = local.user_principal_names
  ignore_missing       = true
}

data "azurerm_role_definition" "this" {
  for_each = local.permissions

  name  = each.value["name"]
  scope = each.value["scope"]
}

locals {
  user_principal_names = distinct(flatten([
    var.owners, var.members
  ]))

  user_object_ids = merge([
    for _, upn in local.user_principal_names : {
      for _, user in data.azuread_users.this.users : upn => user.object_id if user.user_principal_name == upn
    }
  ]...)

  owners  = length(var.owners) > 0 ? compact([for _, upn in var.owners : lookup(local.user_object_ids, upn, "")]) : [data.azuread_client_config.current.object_id]
  members = compact([for _, upn in var.members : lookup(local.user_object_ids, upn, "")])

  permissions = merge([
    for name, scopes in var.assignments : {
      for _, scope in scopes : uuidv5("oid", join("-", [name, scope])) => {
        name  = name
        scope = scope
      }
    }
  ]...)

  assignments = {
    for i, permission in local.permissions : i => {
      principal_id       = azuread_group.this.id
      scope              = permission["scope"]
      role_definition_id = lookup(data.azurerm_role_definition.this, i).id
    }
  }
}

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
