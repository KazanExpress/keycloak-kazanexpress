
data "keycloak_realm" "this" {
  realm = var.realm_name
}

resource "keycloak_role" "test_role" {
  realm_id = data.keycloak_realm.this.id
  name     = "test_role"
}

resource "keycloak_oidc_identity_provider" "realm_identity_provider" {
  realm         = data.keycloak_realm.this.id
  alias         = "yandex"
  client_id     = var.yandex_client_id
  client_secret = var.yandex_client_secret
  provider_id   = "yandex"

  display_name = "Yandex 360"

  authorization_url = "https://authorizationurl.com"
  token_url         = "https://tokenurl.com"
  trust_email       = true
  sync_mode         = "IMPORT"
  default_scopes    = ""

  extra_config = {
    yandexHostedDomain = var.hosted_domain
  }
}