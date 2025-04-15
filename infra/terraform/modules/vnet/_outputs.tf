// _outputs.tf

output "output" {
  value = {
    vnet_name  = azurerm_virtual_network.this.name
    vnet_id    = azurerm_virtual_network.this.id
    subnet_ids = { for key, subnet in azurerm_subnet.this : key => subnet.id }
    nsg_ids    = { for key, nsg in azurerm_network_security_group.this : key => nsg.id }
    bastion    = var.enable_bastion_host ? module.bastion[0].output : null
    nat_gw     = var.enable_nat_gateway ? module.natgw[0].output : null
    vpn_gw     = var.enable_vpn_gateway ? module.vpngw[0].output : null
  }
  description = "Ids for Virtual Nwetwork resources"
}
