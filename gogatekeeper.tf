resource "random_password" "encryption_key" {
  length = 32
  keepers = {
    keep = 1
  }
}

resource "helm_release" "gogatekeeper" {
  name      = var.name
  namespace = var.namespace

  repository = "https://gogatekeeper.github.io/helm-gogatekeeper"
  chart      = "gatekeeper"
  version    = "0.1.18"

  set {
    name  = "config.upstream-url"
    value = var.upstream_url
  }
  set {
    name  = "config.discovery-url"
    value = var.discovery_url
  }
  set {
    name  = "config.client-id"
    value = var.client_id
  }
  set {
    name  = "config.client-secret"
    value = var.client_secret
  }
  set {
    name  = "config.redirection-url"
    value = "https://${var.url}"
  }
  set {
    name  = "config.encryption-key"
    value = random_password.encryption_key.result
  }
  set {
    name  = "config.enable-refresh-tokens"
    value = "true"
  }
  set {
    name  = "extraArgs[0]"
    value = "--skip-access-token-clientid-check"
  }

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "traefik"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.url
  }
  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }
  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "Prefix"
  }

  set {
    name  = "ingress.tls[0].hosts[0]"
    value = var.url
  }
}
