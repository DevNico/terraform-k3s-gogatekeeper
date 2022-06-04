
# Module `terraform-k3s-gogatekeeper`

A Terraform module to deploy a gogatekeeper instance via helm on a kubernetes cluster. This module assumes that all you want is basic authentication and no complex authorization. Feel free to fork this repository and add your own customizations.

Provider Requirements:
* **helm (`hashicorp/helm`):** `>= 2.5.1`
* **kubernetes (`hashicorp/kubernetes`):** `>= 2.0.2`
* **random:** (any version)

## Example Usage

If you want to deploy a gogatekeeper instance for multiple services each with its own subdomain you can use:

```hcl
module "gogatekeeper" {
  for_each = {
    // Map of subdomain = kubernetes_service
    "example" = kubernetes_service.example
  }
  source = "github.com/DevNico/terraform-k3s-gogatekeeper?ref=v0.0.1"

  name      = "${each.value.metadata[0].name}-gatekeeper"
  namespace = each.value.metadata[0].namespace

  url           = "${each.key}.${var.domain}"
  client_id     = local.kc_client_id     # Replace with your respective keycloak client id
  client_secret = local.kc_client_secret # Replace with your respective keycloak secret
  upstream_url  = "http://${each.value.metadata[0].name}.${each.value.metadata[0].namespace}.svc.cluster.local:${each.value.spec[0].port[0].port}"
  discovery_url = local.kc_url           # Replace with your respective keycloak url
}
```

## Input Variables
* `client_id` (required): The keycloak client id
* `client_secret` (required): The keycloak client secret
* `discovery_url` (required): The keycloak discovery url
* `name` (required): The name of the application
* `namespace` (required): The namespace of the application
* `upstream_url` (required): The keycloak discovery url
* `url` (required): The target url

## Managed Resources
* `helm_release.gogatekeeper` from `helm`
* `random_password.encryption_key` from `random`

## Creating a new release
After adding your changed and committing the code to GIT, you will need to add a new tag.
```
git tag vx.x.x
git push --tag
```
If your changes might be breaking current implementations of this module, make sure to bump the major version up by 1.

If you want to see which tags are already there, you can use the following command:
```
git tag --list
```
