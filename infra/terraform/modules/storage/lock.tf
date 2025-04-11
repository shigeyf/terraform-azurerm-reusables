// lock.tf

resource "azurerm_management_lock" "this" {
  count      = var.enable_lock ? 1 : 0
  name       = "lock-${var.storage_account_name}"
  scope      = azurerm_storage_account.this.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion of the resource"

  depends_on = [
    azurerm_storage_account.this,
  ]
}
