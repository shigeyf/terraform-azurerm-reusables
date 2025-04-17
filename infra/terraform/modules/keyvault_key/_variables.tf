// _variables.tf

variable "key_name" {
  type        = string
  description = "Key name"
}

variable "keyvault_id" {
  type        = string
  description = "KeyVault Id"
}

variable "key_policy" {
  type = object(
    {
      key_type        = string
      key_size        = optional(number, 2048)
      curve_type      = optional(string)
      expiration_date = optional(string, null)
      rotation_policy = optional(object(
        {
          automatic = optional(object(
            {
              time_after_creation = optional(string)
              time_before_expiry  = optional(string, "P30D")
            }
          ), null)
          expire_after         = optional(string, "P30D")
          notify_before_expiry = optional(string, "P29D")
        }
      ), null)
    }
  )
  description = "KeyVault Key Policy"
}
