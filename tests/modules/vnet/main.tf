// main.tf

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

// #1 - Create VNet without subnets
module "test1" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0001"
  address_prefix      = "10.10.0.0/16"
}

// #2 - Create VNet with subnets
module "test2" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0002"
  address_prefix      = "10.10.0.0/16"
  subnets = {
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/26"
      naming_prefix_enabled = true
    }
  }
}

// #3 - Create VNet with subnets and NAT Gateway
module "test3" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0003"
  address_prefix      = "10.10.0.0/16"
  subnets = {
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/26"
      naming_prefix_enabled = true
    }
  }
  enable_nat_gateway         = true
  nat_gateway_name           = "${local.nat_gateway_name}0003"
  nat_gateway_public_ip_name = "${local.nat_gateway_public_ip_name}0003"
}

// #4 - Create VNet with subnets and VPN Gateway
module "test4" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0004"
  address_prefix      = "10.10.0.0/16"
  subnets = {
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/26"
      naming_prefix_enabled = true
    },
    "GatewaySubnet" = {
      name                  = "GatewaySubnet"
      address_prefix        = "10.10.1.0/24"
      naming_prefix_enabled = false
    }
  }
  enable_vpn_gateway         = true
  vpn_gateway_name           = "${local.vpn_gateway_name}0004"
  vpn_gateway_public_ip_name = "${local.vpn_gateway_public_ip_name}0004"
}

// #5 - Create VNet with subnets and Bastion Host
module "test5" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0005"
  address_prefix      = "10.10.0.0/16"
  subnets = {
    "AzureBastionSubnet" = {
      name                  = "AzureBastionSubnet"
      address_prefix        = "10.10.2.0/26"
      naming_prefix_enabled = false
    },
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/26"
      naming_prefix_enabled = true
    },
    "GatewaySubnet" = {
      name                  = "GatewaySubnet"
      address_prefix        = "10.10.1.0/24"
      naming_prefix_enabled = false
    }
  }
  enable_bastion_host    = true
  bastion_name           = "${local.bastion_host_name}0005"
  bastion_public_ip_name = "${local.bastion_public_ip_name}0005"
}

// #6 - Create VNet with subnets, NAT Gateway, VPN Gateway, and Bastion Host
module "test6" {
  source              = "../../../infra/terraform/modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = local.location
  tags                = local.tags
  vnet_name           = "${local.vnet_name}0006"
  address_prefix      = "10.10.0.0/16"
  subnets = {
    "AzureBastionSubnet" = {
      name                  = "AzureBastionSubnet"
      address_prefix        = "10.10.2.0/26"
      naming_prefix_enabled = false
    },
    (local.private_endpoint_subnet_index_name) = {
      name                  = local.private_endpoint_subnet_index_name
      address_prefix        = "10.10.0.0/26"
      naming_prefix_enabled = true
    },
    "GatewaySubnet" = {
      name                  = "GatewaySubnet"
      address_prefix        = "10.10.1.0/24"
      naming_prefix_enabled = false
    }
  }
  enable_nat_gateway         = true
  nat_gateway_name           = "${local.nat_gateway_name}0006"
  nat_gateway_public_ip_name = "${local.nat_gateway_public_ip_name}0006"
  enable_vpn_gateway         = true
  vpn_gateway_name           = "${local.vpn_gateway_name}0006"
  vpn_gateway_public_ip_name = "${local.vpn_gateway_public_ip_name}0006"
  enable_bastion_host        = true
  bastion_name               = "${local.bastion_host_name}0006"
  bastion_public_ip_name     = "${local.bastion_public_ip_name}0006"
}

// #7 - Create VNet with Private DNS links
module "test7" {
  source                 = "../../../infra/terraform/modules/vnet"
  resource_group_name    = azurerm_resource_group.this.name
  location               = local.location
  tags                   = local.tags
  vnet_name              = "${local.vnet_name}0007"
  address_prefix         = "10.10.0.0/16"
  private_dns_zone_names = local.private_dns_zones

  depends_on = [
    azurerm_private_dns_zone.this,
  ]
}


output "test1" {
  value = module.test1.output
}

output "test2" {
  value = module.test2.output
}

output "test3" {
  value = module.test3.output
}

output "test4" {
  value = module.test4.output
}

output "test5" {
  value = module.test5.output
}

output "test6" {
  value = module.test6.output
}

output "test7" {
  value = module.test7.output
}
