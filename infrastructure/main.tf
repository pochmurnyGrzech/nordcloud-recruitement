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

# resource "azurerm_app_service_plan" "main" {
#   name                = "${var.prefix}-asp"
#   location            = "${azurerm_resource_group.main.location}"
#   resource_group_name = "${azurerm_resource_group.main.name}"
#   kind                = "Linux"
#   reserved            = true

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }
