terraform {
  required_version = "1.3.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}