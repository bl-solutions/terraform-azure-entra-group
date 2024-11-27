module "wrapper" {
  source = "../"

  for_each = var.items

  assignments  = try(each.value.assignments, var.defaults.assignments, {})
  description  = try(each.value.description, var.defaults.description, "")
  display_name = try(each.value.display_name, var.defaults.display_name)
  members      = try(each.value.members, var.defaults.members, [])
  owners       = try(each.value.owners, var.defaults.owners, [])
}
