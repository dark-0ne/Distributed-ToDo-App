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
resource "google_compute_instance" "mongo_vm" {
  name         = "mongo-${count.index}"
  count        = 3
  machine_type = "e2-medium"
  tags         = ["ssh", "mongo"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
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
    ssh-keys = <<EOF
      SHA256:DKdPgDCu5fP1GRPazwJey/dFngKm+ji1i3EJc0nd31c dark0ne@dark0ne
    EOF
  }
}
