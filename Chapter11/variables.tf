variable "client_id" {
  description = "App registration - Client Id"
  type        = string
  default = ""
}
variable "client_secret" {
  description = "App registration - Client Secret"
  type        = string
  default = ""
}
variable "tenant_id" {
  description = "App registration - Tenant Id"
  type        = string
  default = ""
}
variable "env_name" {
  description = "Enviornment Name"
  type        = string
  default = "DemoEnvironment"
}
variable "env_type" {
  description = "Environment Type"
  type        = string
  default = "Trial"
}
variable "env_location" {
  description = "Environment Type"
  type        = string
  default = "europe"
}
