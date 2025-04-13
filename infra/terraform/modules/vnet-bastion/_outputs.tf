// _outputs.tf

output "output" {
  value = {
    bastion_id     = azurerm_bastion_host.this.id
    bastion_name   = azurerm_bastion_host.this.name
    bastion_pip_id = azurerm_public_ip.this.id
  }
  description = "Outputs of the Bastion Host"
}
