// _d_vnet.tf

module "vnet" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = local.vnet_name
  subnet_name_prefix  = local.subnet_prefix_name
  nsg_name_prefix     = local.nsg_prefix_name
  address_prefix      = "10.10.0.0/16"
  subnets = {
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/28"
      naming_prefix_enabled = true
    }
  }
}
