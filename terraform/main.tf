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

resource "google_compute_network" "vpc_network" {
  name = "todo-app-network"
}
