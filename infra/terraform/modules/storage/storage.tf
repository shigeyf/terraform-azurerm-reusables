// storage.tf

locals {
  _identity_type = var.enable_user_assigned_identity ? "SystemAssigned, UserAssigned" : "SystemAssigned"
  _identity_ids  = var.enable_user_assigned_identity ? [azurerm_user_assigned_identity.this[0].id] : null
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
    type         = local._identity_type
    identity_ids = local._identity_ids
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key,
    ]
  }

  depends_on = [
    azurerm_user_assigned_identity.this,
  ]
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  count                     = var.enable_customer_managed_key ? 1 : 0
  storage_account_id        = azurerm_storage_account.this.id
  key_name                  = var.customer_managed_key_name
  key_vault_id              = var.keyvault_id
  user_assigned_identity_id = var.enable_user_assigned_identity ? azurerm_user_assigned_identity.this[0].id : null

  depends_on = [
    azurerm_storage_account.this,
    time_sleep.wait_for_ra_kv_propagation,
  ]
}
