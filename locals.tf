locals {
  user_principal_names = distinct(flatten([
    var.owners, var.members
  ]))

  user_object_ids = merge([
    for _, upn in local.user_principal_names : {
      for _, user in data.azuread_users.this.users : upn => user.object_id if user.user_principal_name == upn
    }
  ]...)

  owners = compact([for _, upn in var.owners: lookup(local.user_object_ids, upn, "")])
  members = compact([for _, upn in var.members: lookup(local.user_object_ids, upn, "")])

  permissions = merge([
    for name, scopes in var.assignments : {
      for _, scope in scopes : uuidv5("oid", join("-", [role, scope])) => {
        name  = name
        scope = scope
      }
    }
  ]...)

  assignments = {
    for i, permission in local.permissions : i => {
      principal_id = azuread_group.this.id
      scope              = permission["scope"]
      role_definition_id = lookup(data.azurerm_role_definition.this, i).id
    }
  }
}
