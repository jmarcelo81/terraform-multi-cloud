provider "vault" {
    address = "http://10.10.20.12:8200"
    skip_child_token = true
}


ephemeral "vault_kv_secret_v2" "mysecret" {
  mount = "secrets"
  name  = "db_creds_tf_demo"
}

