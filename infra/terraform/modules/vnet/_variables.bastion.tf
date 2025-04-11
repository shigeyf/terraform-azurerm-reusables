// _variables.bastion.tf

variable "enable_bastion_host" {
  description = "Enable Bastion Host"
  type        = bool
  default     = false
}

variable "bastion_name" {
  description = "Bastion Host name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_bastion_host && var.bastion_name == null)
    error_message = "'bastion_name' must be set if 'enable_bastion_host' is enabled."
  }
}

variable "bastion_sku" {
  description = "Bastion Host SKU"
  type        = string
  default     = "Basic"
}

variable "bastion_scale_units" {
  description = "Number of scale units for the Bastion Host"
  type        = number
  default     = 2
}

variable "bastion_public_ip_name" {
  description = "VPN Gateway Public IP name"
  type        = string
  default     = null

  validation {
    condition     = !(var.enable_bastion_host && var.bastion_public_ip_name == null)
    error_message = "'bastion_public_ip_name' must be set if 'enable_bastion_host' is enabled."
  }
}
