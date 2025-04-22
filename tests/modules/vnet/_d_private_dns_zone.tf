// _d_private_dns_zone.tf

locals {
  private_dns_resource_group_name_1 = "rg-${local.naming_suffix}-privatedns1"
  private_dns_resource_group_name_2 = "rg-${local.naming_suffix}-privatedns2"
  private_dns_resource_group_name_3 = "rg-${local.naming_suffix}-privatedns3"
  private_dns_resource_group_names = [
    local.private_dns_resource_group_name_1,
    local.private_dns_resource_group_name_2,
    local.private_dns_resource_group_name_3,
  ]

  private_dns_zones = [
    {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = local.private_dns_resource_group_name_1
    },
    {
      name                = "privatelink.openai.azure.com"
      resource_group_name = local.private_dns_resource_group_name_2
    },
    {
      name                = "privatelink.cognitiveservices.azure.com"
      resource_group_name = local.private_dns_resource_group_name_2
    },
    {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = local.private_dns_resource_group_name_3
    }
  ]
}

resource "azurerm_resource_group" "dns" {
  for_each = { for index, name in local.private_dns_resource_group_names : index => name }
  name     = each.value
  location = local.location
  tags     = local.tags
}

resource "azurerm_private_dns_zone" "this" {
  for_each            = { for index, zone in local.private_dns_zones : index => zone }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = local.tags

  depends_on = [
    azurerm_resource_group.dns,
  ]
}
