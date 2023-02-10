provider "keycloak" {
  client_id = "admin-cli"
  username  = var.keycloack_user
  password  = var.keycloack_password
  url       = var.keycloak_url
  realm     = var.realm_name
  #   base_path     = "/auth"
}