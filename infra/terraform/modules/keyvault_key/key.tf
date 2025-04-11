// key.tf

# This resource is used to ensure that the role assignment is created after the Key Vault is created.
resource "time_sleep" "wait_for_propagation" {
  create_duration = "120s"
  depends_on = [
    var.role_assignment_dependencies,
  ]
}

resource "azurerm_key_vault_key" "this" {
  name         = var.key_name
  key_vault_id = var.keyvault_id
  key_type     = var.key_policy.key_type
  key_size     = var.key_policy.key_size
  curve        = var.key_policy.curve_type

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_after_creation = var.key_policy.rotation_policy.automatic.time_after_creation
      time_before_expiry  = var.key_policy.rotation_policy.automatic.time_before_expiry
    }
    expire_after         = var.key_policy.rotation_policy.expire_after
    notify_before_expiry = var.key_policy.rotation_policy.notify_before_expiry
  }

  depends_on = [
    time_sleep.wait_for_propagation,
  ]
}
