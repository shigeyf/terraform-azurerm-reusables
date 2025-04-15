// _locals.test.tf

locals {
  resource_group_name = "rg-${local.naming_suffix}"
  keyvault_name       = "kv-${local.naming_suffix}"
  key_name            = "key-${local.random}"
}
