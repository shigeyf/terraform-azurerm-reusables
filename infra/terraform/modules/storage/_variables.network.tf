// _variables.network.tf

variable "private_endpoint_name" {
  description = "Private Endpoint name"
  type        = string
  default     = null

  validation {
    condition     = !(!var.enable_public_network_access && var.private_endpoint_name == null)
    error_message = "'private_endpoint_name' must be set if 'enable_public_network_access' is disabled."
  }
}


variable "private_endpoint_subnet_id" {
  description = "Private Endpoint Subnet Id"
  type        = string
  default     = null

  validation {
    condition     = !(!var.enable_public_network_access && var.private_endpoint_subnet_id == null)
    error_message = "'private_endpoint_subnet_id' must be set if 'enable_public_network_access' is disabled."
  }
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of Private DNS Zone Id"
  default     = []
}
