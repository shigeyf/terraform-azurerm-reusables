// _variables.natgw.tf

variable "natgw_name" {
  description = "NAT Gateway name"
  type        = string
}

variable "sku" {
  description = "NAT Gateway SKU"
  type        = string
  default     = "Standard"
}

variable "subnets" {
  description = "Subnets to associate with the NAT Gateway"
  type        = map(string)
  default     = {}
}
