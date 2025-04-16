// kv_role_assignment.tf

resource "azurerm_role_assignment" "ra_kv" {
  count                = var.enable_customer_managed_key ? 1 : 0
  scope                = var.keyvault_id
  principal_id         = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].principal_id : azurerm_storage_account.this.identity[0].principal_id
  role_definition_name = local.role_name_key_vault_crypto_officer

  depends_on = [
    azurerm_storage_account.this,
    azurerm_user_assigned_identity.this,
  ]
}

resource "time_sleep" "wait_for_ra_kv_propagation" {
  count           = var.enable_customer_managed_key ? 1 : 0
  create_duration = var.ra_propagation_time
  depends_on = [
    azurerm_role_assignment.ra_kv,
  ]
}
