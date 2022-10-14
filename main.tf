terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#                   PARAMETERS
variable "rg" {             #   RESOURCE GROUP
    type = string
    default = "rsv_RG"
}
variable "location" {       #   LOCATION
    type = string
    default = "eastus"
}
variable "app_name" {       #   APP NAME
    type = string
    default = "appnamenottaken"
}
variable "app_service_plan_name" {       #   APP SERVICE NAME
    type = string
    default = "aspnottaken"
}

#                   RESOURCES
resource "azurerm_service_plan" "web_app_plan" {        #   APP SERVICE PLAN
  name                = var.app_service_plan_name
  resource_group_name = var.rg
  location            = var.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}
resource "azurerm_windows_web_app" "web_app" {          #   APP SERVICE
  name                = var.app_name
  resource_group_name = azurerm_service_plan.web_app_plan.resource_group_name
  location            = azurerm_service_plan.web_app_plan.location
  service_plan_id     = azurerm_service_plan.web_app_plan.id

  site_config {}
  depends_on = [
    azurerm_service_plan.web_app_plan
  ]
}