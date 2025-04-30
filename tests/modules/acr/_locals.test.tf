// _locals.test.tf

locals {
  resource_group_name                = "rg-${local.naming_suffix}"
  vnet_name                          = "vnet-${local.naming_suffix}"
  subnet_prefix_name                 = "snet"
  nsg_prefix_name                    = "nsg"
  private_endpoint_subnet_index_name = "private-endpoints"
  keyvault_name                      = "kv-${local.naming_suffix}"
  key_name                           = "key-${local.random}"
  acr_name                           = replace("acr-${local.naming_suffix}", "-", "")
  uami_prefix                        = "uami"
  private_endpoint_name              = "pe-${local.acr_name}"
}
