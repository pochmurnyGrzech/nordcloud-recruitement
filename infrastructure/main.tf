provider "azurerm" {
  version = "1.44.0"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg0terraform0we"
    storage_account_name = "st0terraformbackend0we"
    container_name       = "tfstate"
    key                  = "notejam"
  }
}

locals {
  common_tags = map(
    "ApplicationName", "${var.project_name}",
    "Env", terraform.workspace
  )

  name_postfix = "${var.project_name}0${terraform.workspace}0${var.location_shortcut}"
}

resource "azurerm_resource_group" "rg_notejam" {
  name     = "rg0${local.name_postfix}"
  location = var.location

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_application_insights" "appinsights_notejam" {
  name                = "appinsights0${local.name_postfix}"
  location            = azurerm_resource_group.rg_notejam.location
  resource_group_name = azurerm_resource_group.rg_notejam.name
  application_type    = "Node.JS"

    tags = merge(
    local.common_tags
  )
}

resource "azurerm_app_service_plan" "plan_notejam" {
  name                = "plan0${local.name_postfix}"
  location            = azurerm_resource_group.rg_notejam.location
  resource_group_name = azurerm_resource_group.rg_notejam.name
  kind                = var.app_service_plan_kind
  reserved            = var.app_service_plan_reserved
  per_site_scaling    = var.app_service_plan_per_site_scaling

  sku {
    tier     = var.app_service_plan_sku_tier
    size     = var.app_service_plan_sku_size
    capacity = var.app_service_plan_sku_capacity
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_app_service" "app_notejam" {
  name                = "app0${local.name_postfix}"
  location            = azurerm_resource_group.rg_notejam.location
  resource_group_name = azurerm_resource_group.rg_notejam.name
  app_service_plan_id = azurerm_app_service_plan.plan_notejam.id

  site_config {
    always_on        = var.app_service_always_on
    http2_enabled    = true
    linux_fx_version = "NODE|10.18"
    app_command_line = "process.json"
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.appinsights_notejam.instrumentation_key
    WEBSITE_NODE_DEFAULT_VERSION = "10.18.0"
    PORT = "8080"
  }

  tags = merge(
    local.common_tags
  )
}

# resource "azurerm_app_service_slot" "app_notejam_staging" {
#   name                = "app0staging${local.name_postfix}"
#   app_service_name    = azurerm_app_service.app_notejam.name
#   location            = azurerm_resource_group.rg_notejam.location
#   resource_group_name = azurerm_resource_group.rg_notejam.name
#   app_service_plan_id = azurerm_app_service_plan.plan_notejam.id

#   site_config {
#     linux_fx_version = "NODE|10.18"
#   }

#   app_settings = {
#     WEBSITE_NODE_DEFAULT_VERSION = "10.18.0"
#     InstrumentationKey = azurerm_application_insights.appinsights_notejam.instrumentation_key
#   }
# }
