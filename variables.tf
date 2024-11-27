variable "display_name" {
  description = "The name of the Entra group."
  type        = string
}

variable "description" {
  description = "(Optional) Description of the Entra Group."
  type        = string
  default     = ""
}

variable "members" {
  description = "(Optional) List of user principal names to add as members of the group."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "(Optional) List of user principal names to add as owners of the group. If not provided, the principal used by Terraform is used as owner of the group."
  type        = list(string)
  default     = []
}

variable "assignments" {
  description = "(Optional) Right of the group on Azure. See Assignment section of README.md for details."
  type        = map(list(string))
  default     = {}
}
