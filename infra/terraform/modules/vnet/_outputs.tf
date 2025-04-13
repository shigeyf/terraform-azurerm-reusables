// _outputs.tf

output "output" {
  value = {
    vnet_name  = azurerm_virtual_network.this.name
    vnet_id    = azurerm_virtual_network.this.id
    subnet_ids = { for key, subnet in azurerm_subnet.this : key => subnet.id }
    nsg_ids    = { for key, nsg in azurerm_network_security_group.this : key => nsg.id }
    bastion    = bastion.output
    nat_gw     = natgw.output
    vpn_gw     = vpngw.output
  }
  description = "Ids for Virtual Nwetwork resources"
}
