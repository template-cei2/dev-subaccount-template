
terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "1.0.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = "0.53.1"
    }
  }

}

# Please checkout documentation on how best to authenticate against SAP BTP
# via the Terraform provider for SAP BTP
provider "btp" {
  globalaccount = var.globalaccount
  username = var.username
  password = var.password

}

provider "cloudfoundry" {
  api_url  = var.api_url
  user     = var.username
  password = var.password
}
