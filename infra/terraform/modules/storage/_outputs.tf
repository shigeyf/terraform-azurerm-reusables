// _outputs.tf

output "private_storage" {
  value = {
    storage_id     = azurerm_storage_account.this.id
    storage_uai_id = azurerm_user_assigned_identity.this.id
    storage_pe_id  = length(azurerm_private_endpoint.this) > 0 ? azurerm_private_endpoint.this[0].id : null,
  }
  description = "Ids for Storage resources"
}
