// _variables.vpngw.tf

variable "vpngw_name" {
  description = "VPN Gateway name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the VPN Gateway"
  type        = string
}

variable "type" {
  description = "VPN Gateway type"
  type        = string
  default     = "Vpn"
}

variable "vpn_type" {
  description = "VPN Gateway VPN type"
  type        = string
  default     = "RouteBased"
}

variable "sku" {
  description = "VPN Gateway SKU"
  type        = string
  default     = "VpnGw1"
}

variable "generation" {
  description = "VPN Gateway generation"
  type        = string
  default     = "Generation1"
}

variable "active_active" {
  description = "Enable active-active mode"
  type        = bool
  default     = false
}

variable "enable_bgp" {
  description = "Enable BGP"
  type        = bool
  default     = false
}

variable "vpn_client_address_space" {
  description = "values for the VPN client address space"
  type        = list(string)
}
