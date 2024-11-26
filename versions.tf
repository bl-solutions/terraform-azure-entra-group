terraform {
  required_version = ">= 0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.97"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
