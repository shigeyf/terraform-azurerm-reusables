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

variable "storage_uami_name" {
  type        = string
  description = "User-assigned managed identity name"
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
