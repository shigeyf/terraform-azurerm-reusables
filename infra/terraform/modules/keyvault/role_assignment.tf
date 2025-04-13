// role_assignment.tf

resource "azurerm_role_assignment" "ra" {
  for_each = { for index, ra in var.role_assignments : index => ra }

  scope                = azurerm_key_vault.this.id
  principal_id         = each.value.principal_id
  role_definition_name = each.value.role_definition_name

  depends_on = [
    azurerm_key_vault.this,
  ]
}

resource "time_sleep" "wait_for_ra_propagation" {
  create_duration = var.ra_propagation_time
  depends_on = [
    azurerm_role_assignment.ra,
  ]
}
