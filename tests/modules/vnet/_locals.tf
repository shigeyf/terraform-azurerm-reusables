// _locals.tf

# tflint-ignore: terraform_unused_declarations
data "azurerm_client_config" "current" {}

resource "random_string" "random" {
  length  = 4
  numeric = true
  lower   = true
  upper   = false
  special = false
}

locals {
  test_case_name = "vnettest"
  random         = random_string.random.result
  naming_suffix  = "${local.test_case_name}-${local.random}"
  location       = "japanwest"
  tags = {
    "projectTag" = "github.com/shigeyf/terraform-azurerm-reusables"
    "envTag"     = "dev"
    "purposeTag" = "test"
  }
}
