
# Read secrets from GCP secret manager 
data "google_secret_manager_secret_version" "vm-public-key" {
  secret = "VM-Public-Key"
}
