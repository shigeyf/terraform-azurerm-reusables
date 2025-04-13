// _outputs.tf

output "output" {
  value = {
    keyvault_id      = azurerm_key_vault.this.id
    keyvault_pe_id   = length(azurerm_private_endpoint.this) > 0 ? azurerm_private_endpoint.this[0].id : null,
    role_assignments = azurerm_role_assignment.ra,
  }
  description = "Output Ids for KeyVault resources"
}

output "ra_propagation_delay" {
  value       = time_sleep.wait_for_ra_propagation.id
  description = "Delay for role assignments propagation"
}
