// bastion.tf

resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    public_ip_address_id = azurerm_public_ip.this.id
    subnet_id            = var.subnet_id
  }

  scale_units               = var.scale_units
  sku                       = var.sku
  copy_paste_enabled        = true
  file_copy_enabled         = false
  ip_connect_enabled        = false
  kerberos_enabled          = false
  session_recording_enabled = false
  shareable_link_enabled    = false
  tunneling_enabled         = false

  depends_on = [
    azurerm_public_ip.this,
  ]
}
