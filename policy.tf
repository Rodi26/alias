data "vault_policy_document" "edu_admin" {
    rule {
    # Manage namespaces
    path = "sys/namespaces/*" 
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
rule {
# Manage policies
    path = "sys/policies/acl/*" 
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

rule {
# List policies
    path = "sys/policies/acl" 
   capabilities = ["list"]
}
rule {
# Enable and manage secrets engines
   path = "sys/mounts/*" 
   capabilities = ["create", "read", "update", "delete", "list"]
}
rule {
# List available secrets engines
  path = "sys/mounts" 
  capabilities = [ "read" ]
}
rule {
# Create and manage entities and groups
   path = "identity/*" 
   capabilities = ["create", "read", "update", "delete", "list"]
}
rule {
# Manage tokens
   path =  "auth/token/*" 
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
rule {
# Manage secrets at 'edu-secret'
   path = "edu-secret/*" 
   capabilities = ["create", "read", "update", "delete", "list"]
}
}


data "vault_policy_document" "training_admin" {
    rule {
    # Manage namespaces
# Manage namespaces
path = "sys/namespaces/*" 
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
rule {
# Manage policies
path ="sys/policies/acl/*" 
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
rule {
# List policies
path = "sys/policies/acl" 
  capabilities = ["list"]
}
rule {
# Enable and manage secrets engines
path = "sys/mounts/*" 
   capabilities = ["create", "read", "update", "delete", "list"]
}
rule {
# List available secrets engines
 path = "sys/mounts" 
  capabilities = [ "read" ]
}
rule {
# Manage secrets at 'team-secret'
path = "team-secret/*" 
   capabilities = ["create", "read", "update", "delete", "list"]
}
}

resource "vault_policy" "edu-admin" {
    name = "edu-admin"
    namespace = vault_namespace.education.path
    policy = data.vault_policy_document.edu_admin.hcl 
}

resource "vault_policy" "training_admin" {
    name = "training_admin"
    namespace = "${vault_namespace.education.path}/${vault_namespace.training.path}"
    policy = data.vault_policy_document.training_admin.hcl      
}

resource "vault_policy" "certification_admin" {
    name = "training_admin"
    namespace = "${vault_namespace.education.path}/${vault_namespace.certification.path}"
    policy = data.vault_policy_document.training_admin.hcl      
}