// _variables.vnet.tf

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "address_prefix" {
  description = "Address prefix for the virtual network"
  type        = string
}

variable "subnet_name_prefix" {
  description = "Subnet name prefix"
  type        = string
  default     = "snet"
}

variable "nsg_name_prefix" {
  description = "Network Security Group name prefix"
  type        = string
  default     = "nsg"
}

variable "subnets" {
  description = "Subnets configurations"
  type = map(object(
    {
      name                  = string    # Subnet name
      address_prefix        = string    # Subnet address prefix
      naming_prefix_enabled = bool      # Whether to add naming prefix ("snet") to the subnet name
      delegation = optional(set(object( # 'delegation' block
        {
          name = string
          service_delegation = object(
            {
              name    = string
              actions = optional(list(string))
            }
          )
        }
      )))
    }
  ))
  default = {}
}

variable "private_dns_zone_names" {
  description = "Linking Private DNS Zone names"
  type = list(object(
    {
      name                = string
      resource_group_name = string
    }
  ))
  default = []
}
