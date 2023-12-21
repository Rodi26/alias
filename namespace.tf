# Create Namespaces
resource "vault_namespace" "education" {
  path = "education1"
}


resource "vault_namespace" "training" {
  path = "training"
  namespace = vault_namespace.education.path
}

resource "vault_namespace" "certification" {
  path = "certification"
  namespace = vault_namespace.education.path
}