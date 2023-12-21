
// BOB
resource "vault_auth_backend" "userpass" {  
    type = "userpass"
    path = "userpass"
    namespace = vault_namespace.education.path
}

resource "vault_generic_endpoint" "bob" {
    depends_on           = [vault_auth_backend.userpass]
    path                 = "auth/userpass/users/bob"
    ignore_absent_fields = true
    namespace =  vault_namespace.education.path

    data_json = <<EOT
{
  "password": "training"

  
}
EOT
}   

resource "vault_identity_entity" "bob" {
    depends_on = [vault_generic_endpoint.bob]
    name       = "Bob Smith"
    namespace = vault_namespace.education.path
    policies = [vault_policy.edu-admin.name]
  
}

resource "vault_identity_entity_alias" "bob" {
    depends_on = [vault_identity_entity.bob]
    name       = "bob"
    mount_accessor = vault_auth_backend.userpass.accessor
    canonical_id = vault_identity_entity.bob.id
    namespace = vault_namespace.education.path
}   

resource "vault_identity_group" "training_admin" {
    name     = "training_admin"
    policies = [vault_policy.training_admin.name]   
    namespace = "${vault_namespace.education.path}/${vault_namespace.training.path}"
    member_entity_ids = [vault_identity_entity.bob.id]
}



//TOM
resource "vault_auth_backend" "userpass_edu" {  
    type = "userpass"
    path = "userpass_edu"
    namespace = vault_namespace.education.path
}

resource "vault_generic_endpoint" "tom" {
    depends_on           = [vault_auth_backend.userpass_edu]
    path                 = "auth/userpass_edu/users/tom"
    ignore_absent_fields = true
    namespace =  vault_namespace.education.path

    data_json = <<EOT
{
  "password": "training"

  
}
EOT
}   


resource "vault_identity_entity" "tom" {
    depends_on = [vault_generic_endpoint.tom]
    name       = "Tom Smith"
    namespace = vault_namespace.education.path
    policies = [vault_policy.edu-admin.name]
  
}

resource "vault_identity_entity_alias" "tom" {
    depends_on = [vault_identity_entity.tom]
    name       = "tom"
    mount_accessor = vault_auth_backend.userpass_edu.accessor
    canonical_id = vault_identity_entity.bob.id
    namespace = vault_namespace.education.path
}   

resource "vault_identity_group" "certification_admin" {
    name     = "certification_admin"
    policies = [vault_policy.certification_admin.name]
    namespace = "${vault_namespace.education.path}/${vault_namespace.certification.path}"
    member_entity_ids = [vault_identity_entity.tom.id]
}
