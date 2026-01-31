data "cloudflare_zone" "this" {
  filter = {
    name = var.zone
  }
}

resource "cloudflare_zero_trust_access_policy" "this" {
  account_id = var.account_id

  decision   = "allow"
  name       = "allowed-users"

  session_duration = var.session_duration
  include = [for email in var.allowed_emails : {
    email = {
      email = email
    }
  }]
}

resource "cloudflare_zero_trust_access_application" "this" {
  zone_id = data.cloudflare_zone.this.zone_id
  domain  = "${var.domain}.${var.zone}"
  type    = "self_hosted"

  session_duration = var.session_duration

  policies = [{
    id         = cloudflare_zero_trust_access_policy.this.id
    precedence = 1
  }]
}
