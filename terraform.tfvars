#################################
# Provider configuration
#################################

globalaccount                  = "acme-ga"

#################################
# Account settings
#################################

subaccount_name                = "<Placeholder - Replace with your input value>"
subaccount_description         = "<Placeholder - Replace with your input value>"
region                         = "eu10"


#################################
# Entitlements
#################################

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

#################################
# Cloud Foundry Configurations
#################################

cloudfoundry_spaces = ["dev", "test"]

#################################
# Authorization
#################################

subaccount_admins = ["thomas.smith@acme.com"]

subaccount_viewers = []

cloudfoundry_org_users = {
  managers = []
  billing_managers = []
  auditors = []
}

