// variables.storage.tf

variable "storage_account_name" {
  type        = string
  description = "Storage name"
}

variable "account_kind" {
  type        = string
  description = "Storage account kind"
  default     = "StorageV2"
}

variable "account_replication_type" {
  type        = string
  description = "Storage account replication type"
  default     = "LRS"
}

variable "account_tier" {
  type        = string
  description = "Storage account tier"
  default     = "Standard"
}

variable "enable_user_assigned_identity" {
  type        = bool
  description = "Enable user-assigned managed identity"
  default     = false
}

variable "storage_uami_name" {
  type        = string
  description = "User-assigned managed identity name"
  default     = null

  validation {
    condition     = !(var.enable_user_assigned_identity && var.storage_uami_name == null)
    error_message = "'storage_uami_name' must be set if 'enable_user_assigned_identity' is enabled."
  }
}

variable "customer_managed_key_id" {
  type        = string
  description = "Customer-managed Key Id (normail key id or version-less key id)"
  default     = null
}

variable "containers" {
  type = list(object({
    name                  = string
    container_access_type = string
  }))
  description = "List of containers to be created"
  default     = []
}

variable "enable_public_network_access" {
  description = "Enable public network access"
  type        = bool
  default     = true
}
