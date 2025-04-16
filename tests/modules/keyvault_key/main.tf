// main.tf

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

resource "null_resource" "wait_for_propagation" {
  triggers = {
    wait = module.kv.ra_propagation_delay
  }
}

// #1 - Simple Key
module "test1" {
  source      = "../../../infra/terraform/modules/keyvault_key"
  key_name    = "${local.key_name}-001"
  keyvault_id = module.kv.output.keyvault_id
  key_policy = {
    key_type = "RSA"
    key_size = 4096
    rotation_policy = {
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
  depends_on = [
    null_resource.wait_for_propagation,
  ]
}

// #2 - Auto-rotation Key
module "test2" {
  source      = "../../../infra/terraform/modules/keyvault_key"
  key_name    = "${local.key_name}-002"
  keyvault_id = module.kv.output.keyvault_id
  key_policy = {
    key_type = "RSA"
    key_size = 4096
    rotation_policy = {
      automatic = {
        time_before_expiry = "P30D"
      }
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
  depends_on = [
    null_resource.wait_for_propagation,
  ]
}

output "kv" {
  value = module.kv.output
}

output "test1" {
  value = module.test1.output
}

output "test2" {
  value = module.test2.output
}
