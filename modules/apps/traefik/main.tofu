resource "docker_container" "this" {
  name    = "traefik"
  image   = "docker.io/library/traefik:v3.1.6"
  restart = "always"

  security_opts = [
    "no-new-privileges:true",
  ]

  env = [
    "CF_DNS_API_TOKEN_FILE=/cf_api_token",
  ]

  ports {
    internal = 443
    external = 443
    protocol = "tcp"
  }

  volumes {
    host_path      = "/etc/localtime"
    container_path = "/etc/localtime"
    read_only      = true
  }

  volumes {
    host_path      = "/run/user/1000/podman/podman.sock"
    container_path = "/var/run/docker.sock"
    read_only      = true
  }

  dynamic "labels" {
    for_each = {
      "traefik.enable"                           = "true"
      "traefik.http.routers.traefik.service"     = "api@internal"
      "traefik.http.routers.traefik.entrypoints" = "https"
      "traefik.http.routers.traefik.rule"        = "Host(`traefik.unterschicht.tv`)"
      "traefik.http.routers.traefik.tls"         = "true"
      # Authentication
      "traefik.http.middlewares.traefik-auth.basicauth.usersfile" = "/htpasswd"
      "traefik.http.routers.traefik.middlewares"                  = "traefik-auth"
    }
    content {
      label = labels.key
      value = labels.value
    }
  }
}
