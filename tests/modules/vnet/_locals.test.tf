// _locals.test.tf

locals {
  resource_group_name                = "rg-${local.naming_suffix}"
  vnet_name                          = "vnet-${local.naming_suffix}"
  private_endpoint_subnet_index_name = "private-endpoints"
  nat_gateway_public_ip_name         = "pip-${local.naming_suffix}-ng"
  nat_gateway_name                   = "ng-${local.naming_suffix}"
  vpn_gateway_public_ip_name         = "pip-${local.naming_suffix}-vgw"
  vpn_gateway_name                   = "vgw-${local.naming_suffix}"
  bastion_public_ip_name             = "pip-${local.naming_suffix}-snap"
  bastion_host_name                  = "snap-${local.naming_suffix}"
}
