// nsg.tf

resource "azurerm_network_security_group" "this" {
  # No NSG for GatewaySubnet
  for_each = { for index, subnet in var.subnets : index => subnet if subnet.name != local.gateway_subnet_fixed_name }
  name = (
    each.value.naming_prefix_enabled
    ? "${var.nsg_name_prefix}-${var.subnet_name_prefix}-${each.value.name}"
    : "${var.nsg_name_prefix}-${each.value.name}"
  )
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  // NSG Security Rules for AzureBastionSubnet
  dynamic "security_rule" {
    for_each = {
      for i in local.bastion_nsg_security_rules : i.name => i if each.value.name == local.bastion_subnet_fixed_name
    }
    content {
      name                                       = security_rule.value.name
      protocol                                   = security_rule.value.protocol
      source_port_range                          = security_rule.value.source_port_range
      source_port_ranges                         = security_rule.value.source_port_ranges
      destination_port_range                     = security_rule.value.destination_port_range
      destination_port_ranges                    = security_rule.value.destination_port_ranges
      source_address_prefix                      = security_rule.value.source_address_prefix
      source_address_prefixes                    = security_rule.value.source_address_prefixes
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      destination_address_prefix                 = security_rule.value.destination_address_prefix
      destination_address_prefixes               = security_rule.value.destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
      access                                     = security_rule.value.access
      priority                                   = security_rule.value.priority
      direction                                  = security_rule.value.direction
    }
  }
}
