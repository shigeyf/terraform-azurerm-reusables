// _variables.pip.tf

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
}

variable "public_ip_allocation_method" {
  description = "Public IP allocation method"
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "Public IP SKU"
  type        = string
  default     = "Standard"
}

variable "public_ip_sku_tier" {
  description = "Public IP SKU tier"
  type        = string
  default     = "Regional"
}

variable "public_ip_zones" {
  description = "Public IP zones"
  type        = list(string)
  default     = null
}
