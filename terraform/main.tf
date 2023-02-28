terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.54.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-terraform-creds.json")

  project = "ds-course-project-379014"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}

# Setup storage bucket to store terraform state
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "EU"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

# Setup VMs
resource "google_compute_instance" "mongodb_shards" {
  name         = "mongodb-shard${count.index}"
  count        = 3
  machine_type = "e2-medium"
  tags         = ["ssh", "mongodb"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 25
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
      dark0ne:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key.secret_data} dark0ne@gmail.com
    EOT
  }
}

resource "google_compute_instance" "mongodb_cfgSrv" {
  name         = "mongodb-cfgSrv"
  machine_type = "e2-medium"
  tags         = ["ssh", "mongodb"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 25
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata = {
    "ssh-keys" = <<EOT
      dark0ne:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key.secret_data} dark0ne@gmail.com
    EOT
  }
}
