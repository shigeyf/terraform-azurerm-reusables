// key.tf

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

  expiration_date = var.expiration_date != null ? var.expiration_date : null

  dynamic "rotation_policy" {
    for_each = var.key_policy.rotation_policy != null ? [1] : []
    content {
      dynamic "automatic" {
        for_each = var.key_policy.rotation_policy.automatic != null ? [1] : []
        content {
          time_after_creation = var.key_policy.rotation_policy.automatic.time_after_creation
          time_before_expiry  = var.key_policy.rotation_policy.automatic.time_before_expiry
        }
      }
      expire_after         = var.key_policy.rotation_policy.expire_after
      notify_before_expiry = var.key_policy.rotation_policy.notify_before_expiry
    }
  }

  lifecycle {
    ignore_changes = [
      id,
      resource_id,
      version,
      expiration_date,
      n,
      e,
      x,
      y,
      public_key_openssh,
      public_key_pem,
    ]
  }
}
