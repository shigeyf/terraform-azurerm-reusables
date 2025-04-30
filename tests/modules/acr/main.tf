// main.tf

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

// #1 - Simple Container Registry
module "test1" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0001"
  enable_public_network_access  = true
  enable_user_assigned_identity = false
}

// #2 - Standard Container Registry
module "test2" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0002"
  sku                           = "Standard"
  enable_public_network_access  = true
  enable_user_assigned_identity = false
}

// #3 - Premium Container Registry
module "test3" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0003"
  sku                           = "Premium"
  enable_public_network_access  = true
  enable_user_assigned_identity = false
}

// #4 - Premium Container Registry with Private Endpoint
module "test4" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0004"
  sku                           = "Premium"
  enable_public_network_access  = false
  private_endpoint_subnet_id    = module.vnet.output.subnet_ids["private-endpoints"]
  private_endpoint_name         = "${local.private_endpoint_name}0004"
  private_dns_zone_ids          = [azurerm_private_dns_zone.this.id]
  enable_user_assigned_identity = false
}

// #5 - Standard Container Registry with User-Assigned Identity
module "test5" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0005"
  sku                           = "Standard"
  enable_public_network_access  = true
  enable_user_assigned_identity = true
  acr_uami_name                 = "${local.uami_prefix}-${local.acr_name}0005"
}

// #6 - Premium Container Registry with User-Assigned Identity and CMK encryption
module "test6" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0006"
  sku                           = "Premium"
  enable_public_network_access  = true
  enable_user_assigned_identity = true
  acr_uami_name                 = "${local.uami_prefix}-${local.acr_name}0006"
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  key_vault_key_id              = module.key1.output.key_id
}

// #7 - Premium Container Registry with Private Endpoint, User-Assigned Identity, and CMK encryption
module "test7" {
  source                        = "../../../infra/terraform/modules/acr"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = local.location
  tags                          = local.tags
  container_registry_name       = "${local.acr_name}0007"
  sku                           = "Premium"
  enable_public_network_access  = false
  private_endpoint_subnet_id    = module.vnet.output.subnet_ids["private-endpoints"]
  private_endpoint_name         = "${local.private_endpoint_name}0007"
  private_dns_zone_ids          = [azurerm_private_dns_zone.this.id]
  enable_user_assigned_identity = true
  acr_uami_name                 = "${local.uami_prefix}-${local.acr_name}0007"
  enable_customer_managed_key   = true
  keyvault_id                   = module.kv.output.keyvault_id
  key_vault_key_id              = module.key2.output.key_versionless_id
}
