// _outputs.tf

output "output" {
  value = {
    storage_id     = azurerm_storage_account.this.id
    storage_uai_id = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null
    storage_pe_id  = length(azurerm_private_endpoint.this) > 0 ? azurerm_private_endpoint.this[0].id : null,
  }
  description = "Ids for Storage resources"
}

output "ra_propagation_delay" {
  value       = time_sleep.wait_for_ra_propagation.id
  description = "Delay for role assignments propagation"
}
