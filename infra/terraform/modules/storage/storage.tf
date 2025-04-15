// storage.tf

# This resource is used to ensure that the role assignment is created after the Key Vault is created.
resource "time_sleep" "wait_for_kv_ra_propagation" {
  count           = var.enable_user_assigned_identity ? 1 : 0
  create_duration = var.ra_propagation_time
  depends_on = [
    azurerm_user_assigned_identity.this,
    azurerm_role_assignment.ra_kv,
  ]
}

locals {
  identity_type = var.enable_user_assigned_identity ? "SystemAssigned, UserAssigned" : "SystemAssigned"
  identity_ids  = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.this[0].id] : null
}

resource "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  account_kind                    = var.account_kind
  account_replication_type        = var.account_replication_type
  account_tier                    = var.account_tier
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  nfsv3_enabled                   = false
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = var.enable_public_network_access

  identity {
    type         = local.identity_type
    identity_ids = local.identity_ids
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key_id != null && var.enable_user_assigned_identity ? [1] : []
    content {
      key_vault_key_id = var.customer_managed_key_id
      // Do not add key version in the key_id here, it will be automatically set to the latest version of the key
      user_assigned_identity_id = azurerm_user_assigned_identity.this[0].id
    }
  }

  depends_on = [
    time_sleep.wait_for_kv_ra_propagation,
    azurerm_user_assigned_identity.this,
    azurerm_role_assignment.ra_kv,
  ]
}
