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

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "kv_notejam" {
  name                = "kv0${local.name_postfix}"
  location            = azurerm_resource_group.rg_notejam.location
  resource_group_name = azurerm_resource_group.rg_notejam.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get", "create",
    ]

    secret_permissions = [
      "get", "set", "list"
    ]
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_key_vault_secret" "kvs_notejam_db_password" {
  name         = "DbPassword"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.kv_notejam.id

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_key_vault_secret" "kvs_notejam_db_login" {
  name         = "DbLogin"
  value        = var.db_login
  key_vault_id = azurerm_key_vault.kv_notejam.id

  tags = merge(
    local.common_tags
  )
}

data "azurerm_key_vault_secret" "kvs_notejam_db_password" {
  name         = azurerm_key_vault_secret.kvs_notejam_db_password.name
  key_vault_id = azurerm_key_vault.kv_notejam.id
}

data "azurerm_key_vault_secret" "kvs_notejam_db_login" {
  name         = azurerm_key_vault_secret.kvs_notejam_db_login.name
  key_vault_id = azurerm_key_vault.kv_notejam.id
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
    WEBSITE_NODE_DEFAULT_VERSION   = "10.18.0"
    PORT                           = "8080"
    CONNECTION_STRING              = "postgres://${data.azurerm_key_vault_secret.kvs_notejam_db_login.value}@${azurerm_postgresql_server.psqldb_notejam.name}:${data.azurerm_key_vault_secret.kvs_notejam_db_password.value}@${azurerm_postgresql_server.psql_notejam.fqdn}/${azurerm_postgresql_database.psqldb_notejam.name}?ssl=true"
    DB_NAME                        = azurerm_postgresql_database.psqldb_notejam.name
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_postgresql_server" "psql_notejam" {
  name                = "psql0${local.name_postfix}"
  location            = azurerm_resource_group.rg_notejam.location
  resource_group_name = azurerm_resource_group.rg_notejam.name

  sku_name = "GP_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = data.azurerm_key_vault_secret.kvs_notejam_db_login.value
  administrator_login_password = data.azurerm_key_vault_secret.kvs_notejam_db_password.value
  version                      = "11"
  ssl_enforcement              = "Enabled"

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_postgresql_database" "psqldb_notejam" {
  name                = "psqldb0${local.name_postfix}"
  resource_group_name = azurerm_resource_group.rg_notejam.name
  server_name         = azurerm_postgresql_server.psql_notejam.name

  charset   = "UTF8"
  collation = "English_United States.1252"
}

# Replica is not suppoerted in terraform right now
# resource "azurerm_postgresql_database" "psqldb_notejam_replica" {
#   name                = "psqldb0replica0${local.name_postfix}"
#   resource_group_name = azurerm_resource_group.rg_notejam.name
#   server_name         = azurerm_postgresql_server.psql_notejam.name
#
#   charset   = "UTF8"
#   collation = "English_United States.1252"
# }


# resource "azurerm_network_security_group" "nsg_notejam" {
#   name                = "nsg0${local.name_postfix}"
#   location            = azurerm_resource_group.rg_notejam.location
#   resource_group_name = azurerm_resource_group.rg_notejam.name
# }

# resource "azurerm_virtual_network" "vnet_notejam" {
#   name                = "vnet0${local.name_postfix}"
#   location            = azurerm_resource_group.rg_notejam.location
#   resource_group_name = azurerm_resource_group.rg_notejam.name
#   address_space       = ["10.0.0.0/24"]

#   tags = merge(
#     local.common_tags
#   )
# }

# resource "azurerm_subnet" "snet_app_notejam" {
#   name                 = "snet0app0${local.name_postfix}"
#   resource_group_name  = azurerm_resource_group.rg_notejam.name
#   virtual_network_name = azurerm_virtual_network.vnet_notejam.name
#   address_prefix       = "10.0.0.0/25"

#   delegation {
#     name = "acctestdelegation"

#     service_delegation {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "snet_db_notejam" {
#   name                 = "snet0db${local.name_postfix}"
#   resource_group_name  = azurerm_resource_group.rg_notejam.name
#   virtual_network_name = azurerm_virtual_network.vnet_notejam.name
#   address_prefix       = "10.0.0.128/25"

#   service_endpoints = ["Microsoft.Sql"]
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "vnet_app_connection_notejam" {
#   app_service_id = azurerm_app_service.app_notejam.id
#   subnet_id      = azurerm_subnet.snet_app_notejam.id
# }

# resource "azurerm_postgresql_virtual_network_rule" "vnetrule_db_notejam" {
#   name                = "vnetrule0db0${local.name_postfix}"
#   resource_group_name = azurerm_resource_group.rg_notejam.name
#   server_name         = azurerm_postgresql_server.psql_notejam.name
#   subnet_id           = azurerm_subnet.snet_db_notejam.id
# }

resource "azurerm_postgresql_firewall_rule" "psql_app_firewall_rules_notejam" {
  count               = length(split(",", azurerm_app_service.app_notejam.possible_outbound_ip_addresses))
  name                = "App_Notejam_${count.index}"
  resource_group_name = azurerm_resource_group.rg_notejam.name
  server_name         = azurerm_postgresql_server.psql_notejam.name
  start_ip_address    = split(",", azurerm_app_service.app_notejam.possible_outbound_ip_addresses)[count.index]
  end_ip_address      = split(",", azurerm_app_service.app_notejam.possible_outbound_ip_addresses)[count.index]
}

resource "azurerm_postgresql_firewall_rule" "psql_az_firewall_rule_notejam" {
  name                = "Azure"
  resource_group_name = azurerm_resource_group.rg_notejam.name
  server_name         = azurerm_postgresql_server.psql_notejam.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
