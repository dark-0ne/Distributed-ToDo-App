
# Read secrets from GCP secret manager 
data "google_secret_manager_secret_version" "vm-public-key" {
  secret = "VM-Public-Key"
}

data "google_secret_manager_secret_version" "mongodb-pwd" {
  secret = "MongoDB-Pwd"
}
