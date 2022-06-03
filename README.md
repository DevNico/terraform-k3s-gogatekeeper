
# Module `terraform-gogatekeeper`

Provider Requirements:
* **helm (`hashicorp/helm`):** `>= 2.5.1`
* **kubernetes (`hashicorp/kubernetes`):** `>= 2.0.2`
* **random:** (any version)

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
