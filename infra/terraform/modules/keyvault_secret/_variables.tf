// _variables.tf

variable "secret_name" {
  type        = string
  description = "Secret name"
}

variable "secret_value" {
  type        = string
  description = "Secret value"
  sensitive   = true
}

variable "keyvault_id" {
  type        = string
  description = "KeyVault Id"
}
