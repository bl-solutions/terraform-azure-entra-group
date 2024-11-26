variable "display_name" {
  description = "The name of the Entra group."
  type        = string
}

variable "description" {
  description = "The description of the Entra Group."
  type        = string
  default     = ""
}

variable "members" {
  description = "A list of users including the group."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "A list of owners including the group."
  type        = list(string)
  default     = []
}

variable "assignments" {
  description = "Right of the group on Azure."
  type        = map(list(string))
  default     = {}
}
