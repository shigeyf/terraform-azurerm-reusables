// _variables.vpngw.tf

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "vpn_gateway_name" {
  description = "VPN Gateway name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_vpn_gateway && var.vpn_gateway_name == null)
    error_message = "'vpn_gateway_name' must be set if 'enable_vpn_gateway' is enabled."
  }
}

variable "vpn_gateway_client_address_space" {
  description = "VPN Gateway client address space"
  type        = list(string)
  default     = []
}

variable "vpn_gateway_type" {
  description = "VPN Gateway type"
  type        = string
  default     = "Vpn"
}

variable "vpn_gateway_vpn_type" {
  description = "VPN Gateway VPN type"
  type        = string
  default     = "RouteBased"
}

variable "vpn_gateway_sku" {
  description = "VPN Gateway SKU"
  type        = string
  default     = "VpnGw1"
}

variable "vpn_gateway_public_ip_name" {
  description = "VPN Gateway Public IP name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_vpn_gateway && var.vpn_gateway_public_ip_name == null)
    error_message = "'vpn_gateway_public_ip_name' must be set if 'enable_vpn_gateway' is enabled."
  }
}
