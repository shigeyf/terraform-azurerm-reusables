// _outputs.tf

output "output" {
  value = {
    natgw_id     = azurerm_nat_gateway.this.id
    natgw_name   = azurerm_nat_gateway.this.name
    natgw_pip_id = azurerm_public_ip.this.id
  }
  description = "Outputs of the NAT Gateway"
}
