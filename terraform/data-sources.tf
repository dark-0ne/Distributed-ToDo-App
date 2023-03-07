
# Read secrets from GCP secret manager 
data "google_secret_manager_secret_version" "vm-public-key" {
  secret = "VM-Public-Key"
}

data "google_secret_manager_secret_version" "vm-public-key-2" {
  secret = "VM-Public-Key-2"
}

data "google_secret_manager_secret_version" "mongodb-pwd" {
  secret = "MongoDB-Pwd"
}

data "google_secret_manager_secret_version" "cloudflare-api-key" {
  secret = "Cloudflare-API-Key"
}

data "google_secret_manager_secret_version" "cloudflare-api-token" {
  secret = "Cloudflare-API-Token"
}
