// main.tf

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

// #1 - Simple Key Vault
module "test1" {
  source                       = "../../../infra/terraform/modules/keyvault"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = local.location
  tags                         = local.tags
  keyvault_name                = "${local.keyvault_name}0001"
  enable_public_network_access = true
  role_assignments = [
    {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
    },
  ]
}

// #2 - Key Vault with Private Endpoint
module "test2" {
  source                       = "../../../infra/terraform/modules/keyvault"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = local.location
  tags                         = local.tags
  keyvault_name                = "${local.keyvault_name}0002"
  enable_public_network_access = false
  private_endpoint_subnet_id   = module.vnet.output.subnet_ids["private-endpoints"]
  private_endpoint_name        = "${local.private_endpoint_name}0002"
  private_dns_zone_ids         = [azurerm_private_dns_zone.vaultcore.id]
  role_assignments = [
    {
      principal_id         = data.azurerm_client_config.current.object_id
      role_definition_name = "Key Vault Administrator"
    },
  ]
}
