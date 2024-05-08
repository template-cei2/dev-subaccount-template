###
# Setup of names in accordance to the company's naming conventions
###
locals {
  project_subaccount_name   = "${var.subaccount_name}"
  project_subaccount_domain = lower(replace("${var.subaccount_name}", " ", "-"))
  project_subaccount_cf_org = replace("${var.subaccount_name}", " ", "-")
}

###
# Creation of subaccount
###
resource "btp_subaccount" "project" {
  name      = local.project_subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
  usage = "NOT_USED_FOR_PRODUCTION"
}

###
# Assignment of entitlements
###
resource "btp_subaccount_entitlement" "entitlements" {
  for_each = {
    for index, entitlement in concat(var.entitlement_services, var.entitlement_subscriptions) :
    index => entitlement
  }

  subaccount_id = btp_subaccount.project.id
  service_name  = each.value.name
  plan_name     = each.value.plan
  amount        = each.value.amount
}

###
# Creation of environment instance
###

resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.project.id
  name             = local.project_subaccount_cf_org
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "standard"
  landscape_label  = "cf-eu10"


  parameters = jsonencode({
    instance_name = local.project_subaccount_cf_org
    
  })
}

resource "cloudfoundry_org_users" "cf_org_users" {
  org              = btp_subaccount_environment_instance.cloudfoundry.platform_id
  managers         = var.cloudfoundry_org_users.managers
  billing_managers = var.cloudfoundry_org_users.billing_managers
  auditors         = var.cloudfoundry_org_users.auditors

  depends_on = [btp_subaccount_environment_instance.cloudfoundry]
}

resource "cloudfoundry_space" "cf_spaces" {
  for_each = var.cloudfoundry_spaces
  name = each.key
  org  = btp_subaccount_environment_instance.cloudfoundry.platform_id
}


###
# Creation of service instance
###

data "btp_subaccount_service_plan" "service_instance_plans" {
  for_each = {
    for index, entitlement in var.entitlement_services :
    index => entitlement if entitlement.create_instance != false
  }

  subaccount_id = btp_subaccount.project.id
  name          = each.value.plan
  offering_name = each.value.name
  depends_on    = [btp_subaccount_entitlement.entitlements]
}

resource "btp_subaccount_service_instance" "instances" {
  for_each          = data.btp_subaccount_service_plan.service_instance_plans
  name              = data.btp_subaccount_service_plan.service_instance_plans[each.key].offering_name
  serviceplan_id = data.btp_subaccount_service_plan.service_instance_plans[each.key].id
  subaccount_id  = btp_subaccount.project.id
  depends_on     = [data.btp_subaccount_service_plan.service_instance_plans]
}

data "btp_subaccount_environments" "all" {
  subaccount_id = btp_subaccount.project.id
}


###
# Creation of app subscription
###
resource "btp_subaccount_subscription" "subscriptions" {
  for_each = {
    for index, subscription in var.entitlement_subscriptions :
    index => subscription
  }

  subaccount_id = btp_subaccount.project.id
  app_name      = each.value.name
  plan_name     = each.value.plan
  depends_on    = [btp_subaccount_entitlement.entitlements]
}

###
# Assignment of Subaccount Role Collections
###
resource "btp_subaccount_role_collection_assignment" "subaccount_admins" {
  for_each             = toset(var.subaccount_administrator_users)
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
}

resource "btp_subaccount_role_collection_assignment" "subaccount_admins_user_groups" {
  for_each = {
    for index, user_group in var.subaccount_administrator_user_groups :
    index => user_group
  }
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Administrator"
  group_name           = each.value.name
  origin               = each.value.origin
}

resource "btp_subaccount_role_collection_assignment" "subaccount_viewers" {
  for_each             = toset(var.subaccount_viewer_users)
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Viewer"
  user_name            = each.value
}

resource "btp_subaccount_role_collection_assignment" "subaccount_viewers_user_groups" {
  for_each = {
    for index, user_group in var.subaccount_viewer_user_groups :
    index => user_group
  }
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Viewer"
  group_name           = each.value.name
  origin               = each.value.origin
}