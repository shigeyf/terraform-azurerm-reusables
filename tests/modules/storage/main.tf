// main.tf

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

// #1 - Simple Storage
module "test1" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0001"
  enable_public_network_access  = true
  enable_user_assigned_identity = false
}

// #2 - Storage with Key Vault and managed identity and customer managed key
module "test2" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0002"
  enable_public_network_access  = true
  enable_user_assigned_identity = false
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  customer_managed_key_name     = module.key1.output.key_name
}

// #3 - Storage with Key Vault, user-assigned managed identity, and customer managed key
module "test3" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0003"
  enable_public_network_access  = true
  enable_user_assigned_identity = true
  storage_uami_name             = "${local.uami_prefix}-${local.storage_account_name}0003"
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  customer_managed_key_name     = module.key1.output.key_name
}

// #4 - Storage with Key Vault, user-assigned managed identity, and auto-rotated customer managed key
module "test4" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0004"
  enable_public_network_access  = true
  enable_user_assigned_identity = true
  storage_uami_name             = "${local.uami_prefix}-${local.storage_account_name}0004"
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  customer_managed_key_name     = module.key2.output.key_name
}

// #5 - Storage with Private Endpoint
module "test5" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0005"
  enable_public_network_access  = false
  private_endpoint_subnet_id    = module.vnet.output.subnet_ids["private-endpoints"]
  private_endpoint_name         = "${local.private_endpoint_name}0005"
  private_dns_zone_ids          = [azurerm_private_dns_zone.blob.id]
  enable_user_assigned_identity = false
}

// #6 - Storage with Private Endpoint, Key Vault, and user-assigned managed identity and auto-rotated customer managed key
module "test6" {
  source                        = "../../../infra/terraform/modules/storage"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  storage_account_name          = "${local.storage_account_name}0006"
  enable_public_network_access  = false
  private_endpoint_subnet_id    = module.vnet.output.subnet_ids["private-endpoints"]
  private_endpoint_name         = "${local.private_endpoint_name}0006"
  private_dns_zone_ids          = [azurerm_private_dns_zone.blob.id]
  enable_user_assigned_identity = true
  storage_uami_name             = "${local.uami_prefix}-${local.storage_account_name}0006"
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  customer_managed_key_name     = module.key2.output.key_name
}

output "kv" {
  value = module.kv.output
}

output "key1" {
  value = module.key1.output
}

output "key2" {
  value = module.key2.output
}

output "vnet" {
  value = module.vnet.output
}

output "test1" {
  value = module.test1.output
}

output "test2" {
  value = module.test2.output
}

output "test3" {
  value = module.test2.output
}

output "test4" {
  value = module.test2.output
}
output "test5" {
  value = module.test2.output
}

output "test6" {
  value = module.test2.output
}
