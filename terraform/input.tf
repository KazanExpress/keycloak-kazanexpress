variable "realm_name" {
  type        = string
  description = "Name of the realm to create"
  default     = "master"
}

variable "keycloack_user" {
  type        = string
  description = "Keycloak admin user"
  default     = "admin"
}

variable "keycloack_password" {
  type        = string
  description = "Keycloak admin password"
  default     = "password"
}

variable "keycloak_url" {
  type        = string
  description = "Keycloak url"
  default     = "http://localhost:8080"
}

variable "yandex_client_id" {
  type        = string
  description = "Yandex client id"
}

variable "yandex_client_secret" {
  description = "Yandex client string"
  type        = string
  sensitive   = true
}

variable "hosted_domain" {
  type        = string
  description = "Domain for checking email"
}