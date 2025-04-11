// _outputs.tf

output "output" {
  value = {
    vpngw_id     = azurerm_virtual_network_gateway.this.id
    vpngw_name   = azurerm_virtual_network_gateway.this.name
    vpngw_pip_id = azurerm_public_ip.this.id
  }
  description = "Outputs of the VPN Gateway"
}
