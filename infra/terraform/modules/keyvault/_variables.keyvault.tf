// _variables.keyvault.tf

variable "keyvault_name" {
  type        = string
  description = "Key Vault name"
}

variable "enable_public_network_access" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Enable RBAC authorization"
  type        = bool
  default     = true
}

variable "enabled_for_deployment" {
  description = "Enable deployment"
  type        = bool
  default     = false
}
variable "enabled_for_disk_encryption" {
  description = "Enable disk encryption"
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Enable template deployment"
  type        = bool
  default     = false
}
variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = false
}
variable "soft_delete_retention_days" {
  description = "Soft delete retention days"
  type        = number
  default     = 7
}
