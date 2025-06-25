// _locals.snet.tf

locals {
  bastion_subnet_fixed_name      = "AzureBastionSubnet"
  gateway_subnet_fixed_name      = "GatewaySubnet"
  enable_default_outbound_access = var.enable_nat_gateway ? false : true
}
