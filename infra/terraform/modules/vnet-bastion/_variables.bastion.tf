// _variables.bastion.tf

variable "bastion_name" {
  description = "Bastion Host name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet Id for the Bastion Host"
  type        = string
}

variable "sku" {
  description = "Bastion Host SKU"
  type        = string
  default     = "Basic"
}

variable "scale_units" {
  description = "Number of scale units for the Bastion Host"
  type        = number
  default     = 2
}
