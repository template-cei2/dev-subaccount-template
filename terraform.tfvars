###
# Provider configuration
###

globalaccount                  = "acme-ga"

###
# Account settings
###

subaccount_name                = "<Placeholder - Replace with your input value>"
subaccount_description         = "<Placeholder - Replace with your input value>"
region                         = "eu10"


###
# Entitlements
###

entitlement_services = [
    {
      name   = "application-logs"
      plan   = "lite"
      amount = 2
      create_instance = true
    },
    {
      name    = "destination"
      plan    = "lite"
      amount  = 2
      create_instance = true
    }
]

entitlement_subscriptions = []

###
# Cloud Foundry Configurations
###

cloudfoundry_spaces = ["dev", "test"]

###
# Authorization
###

subaccount_administrator_users = ["thomas.smith@acme.com"]
subaccount_administrator_user_groups = [
  {
    name = "it-admin-team"
    origin = "acme-idp"
  }
]

subaccount_viewer_users = []
subaccount_viewer_user_groups = []

cloudfoundry_org_users = {
  managers = []
  billing_managers = []
  auditors = []
}

