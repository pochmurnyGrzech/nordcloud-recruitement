variable "location" {
  description = "Location of the resources. By default: west europe"
}

variable "location_shortcut" {
  description = "Shortut of location for resource naming"
}
variable "project_name" {
  description = "Name of the project"
}

variable "app_service_plan_kind" {
  description = "Kind of the app service plan. Possibilities: Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan)."
}

variable "app_service_plan_reserved" {
  
}


variable "app_service_plan_sku_tier" {
  
}

variable "app_service_plan_sku_size" {
  
}


variable "app_service_plan_sku_capacity" {
  
}

variable "app_service_plan_per_site_scaling" {

}

variable "app_service_always_on" {
  
}

#############
# Should be in separeted module
#############
variable "db_password" {
  
}

#############
# Should be in separeted module
#############
variable "db_login" {
  
}