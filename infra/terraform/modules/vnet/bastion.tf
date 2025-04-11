// bastion.tf

module "bastion" {
  count               = var.enable_bastion_host ? 1 : 0
  source              = "../vnet-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  bastion_name        = var.bastion_name
  public_ip_name      = var.bastion_public_ip_name
  sku                 = var.bastion_sku
  scale_units         = var.bastion_scale_units
  subnet_id           = azurerm_subnet.this[local.bastion_subnet_fixed_name].id
}
