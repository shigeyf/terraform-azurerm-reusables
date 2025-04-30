// _d_kv.tf

module "kv" {
  source                       = "../../../infra/terraform/modules/keyvault"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = local.location
  tags                         = local.tags
  keyvault_name                = local.keyvault_name
  enable_public_network_access = true
  role_assignments = [
    {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
    },
  ]
}

resource "null_resource" "wait_for_propagation" {
  triggers = {
    wait = module.kv.ra_propagation_delay
  }
}

module "key1" {
  source      = "../../../infra/terraform/modules/keyvault_key"
  key_name    = "${local.key_name}-001"
  keyvault_id = module.kv.output.keyvault_id
  key_policy = {
    key_type        = "RSA"
    key_size        = 4096
    expiration_date = timeadd(timestamp(), "1h")
    rotation_policy = {
      expire_after         = "P90D"
      notify_before_expiry = "P29D"
    }
  }
  depends_on = [
    null_resource.wait_for_propagation,
  ]
}

module "key2" {
  source      = "../../../infra/terraform/modules/keyvault_key"
  key_name    = "${local.key_name}-002"
  keyvault_id = module.kv.output.keyvault_id
  key_policy = {
    key_type        = "RSA"
    key_size        = 4096
    expiration_date = timeadd(timestamp(), "1h")
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
