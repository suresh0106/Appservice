provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.78.0"
    }
  }
}
resource "azurerm_resource_group" "RG" {
  name     = "app_terraform_rg"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "App" {
  name                = "test-appservice"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  sku {
    tier = "Standard"
    size = "S2"
  }
}
resource "azurerm_app_service" "APPSERVTESTS" {
  name                = "appservtests"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  app_service_plan_id = azurerm_app_service_plan.App.id

  site_config {
    dotnet_framework_version = "v4.0"
  }
}