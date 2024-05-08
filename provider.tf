###
# Required providers and versions
###

terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "~> 1.3.0"
    }
    cloudfoundry = {
      source  = "SAP/cloudfoundry"
      version = "0.1.0-beta"
    }
  }

}

###
# Please checkout documentation on how best to authenticate against the providers
# Terraform provider for SAP BTP: https://registry.terraform.io/providers/SAP/btp/latest/docs
# Terraform provider for Cloud Foundry: https://registry.terraform.io/providers/SAP/cloudfoundry/latest/docs
###

provider "btp" {
  globalaccount = var.globalaccount
  username      = var.username
  password      = var.password
}

provider "cloudfoundry" {
  api_url  = var.api_url
  user     = var.username
  password = var.password
}
