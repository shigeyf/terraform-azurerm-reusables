// _outputs.tf

output "output" {
  value = {
    key_id             = azurerm_key_vault_key.this.id
    key_versionless_id = azurerm_key_vault_key.this.versionless_id
    key_name           = azurerm_key_vault_key.this.name
  }
  description = "Ids for KeyVault Key"
}
