###
# Common Provider authentication configuration
# This could also be provided as environment variables: https://registry.terraform.io/providers/SAP/btp/latest/docs#optional
###
variable "username" {
  type        = string
  description = "Your username for the SAP BTP global account and for Cloud Foundry environment."
  default     = "btp_username"
}

variable "password" {
  type        = string
  description = "Your password for the SAP BTP global account and for Cloud Foundry environment."
  default     = "btp_password"
}

###
# BTP Provider configuration
###
variable "globalaccount" {
  type        = string
  description = "The subdomain of the SAP BTP global account."
  default     = ""
}

###
# Cloud Foundry Provider configuration
# The API URL might not be the same for all regions and extension landscapes
###
variable "api_url" {
  type        = string
  description = "The API Endpoint URL of the Cloud Foundry environment instance."
  default     = "https://api.cf.eu10.hana.ondemand.com"
}

###
# Subaccount setup
###
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "subaccount"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_\\-]{1,200}", var.subaccount_name))
    error_message = "Provide a valid subaccount name."
  }
}

variable "subaccount_description" {
  type        = string
  description = "The subaccount description."
}

variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "eu10"
}


###
# Entitlements for Services
###
variable "entitlement_services" {
  type = list(object({
    name            = string
    plan            = string
    amount          = number
    create_instance = bool
  }))
  description = "List of entitlements of service instances for the subaccount."
  default     = []
}

variable "entitlement_subscriptions" {
  type = list(object({
    name                = string
    plan                = string
    amount              = number
    create_subscription = bool
  }))
  description = "List of entitlements of service subscriptions for the subaccount."
  default     = []
}

###
# Service Instances
###
variable "instances" {
  type = list(object({
    name = string
    plan = string
  }))
  description = "List of service instances to be created to in the subaccount."
  default     = []
}


###
# Service Subscriptions
###
variable "subscriptions" {
  type = list(object({
    app_name = string
    plan     = string
  }))
  description = "List of service subscriptions to be subscribed to in the subaccount."
  default     = []
}

###
# Cloud Foundry Configuration
###

variable "cloudfoundry_spaces" {
  type        = set(string)
  description = "List of Cloud Foundry spaces to be created in the subaccount."
  default     = ["dev"]
}

###
# Authorization
###
variable "subaccount_administrator_users" {
  type        = set(string)
  description = "List of users to be assigned the Role Collection 'Subaccount Administrator'."
}

variable "subaccount_administrator_user_groups" {
  type = list(object({
    name   = string
    origin = string
  }))
  description = "List of user groups to be assigned the Role Collection 'Subaccount Administrator'."
}

variable "subaccount_viewer_users" {
  type        = set(string)
  description = "List of users to be assigned the Role Collection 'Subaccount Viewer'."
}

variable "subaccount_viewer_user_groups" {
  type = list(object({
    name   = string
    origin = string
  }))
  description = "List of user groups to be assigned the Role Collection 'Subaccount Viewer'."
}

variable "cloudfoundry_org_users" {
  type = object({
    managers         = set(string)
    billing_managers = set(string)
    auditors         = set(string)
  })
  description = "List of users to be assigned to Cloud Foundry roles."
}
