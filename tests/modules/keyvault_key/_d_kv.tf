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
