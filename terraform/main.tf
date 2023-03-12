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
resource "google_compute_instance" "mongodb-shard0" {
  name         = "mongodb-shard0-${count.index}"
  count        = 3
  machine_type = var.mongodb_shard_vm_type
  tags         = ["ssh", "mongodb-shard"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
      type  = "pd-ssd"
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mongodb-shard1" {
  name         = "mongodb-shard1-${count.index}"
  count        = 3
  machine_type = var.mongodb_shard_vm_type
  tags         = ["ssh", "mongodb-shard"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
      type  = "pd-ssd"
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mongodb-shard2" {
  name         = "mongodb-shard2-${count.index}"
  count        = 3
  machine_type = var.mongodb_shard_vm_type
  tags         = ["ssh", "mongodb-shard"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
      type  = "pd-ssd"
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mongodb-cfgsrv" {
  name         = "mongodb-cfgsrv-${count.index}"
  count        = 3
  machine_type = "e2-standard-2"
  tags         = ["ssh", "mongodb-cfgsrv"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mongodb-router" {
  name         = "mongodb-router-${count.index}"
  count        = 3
  machine_type = var.mongodb_router_vm_type
  tags         = ["ssh", "mongodb-router"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mongo-express" {
  name         = "mongo-express-0"
  machine_type = "e2-medium"
  tags         = ["ssh", "mongoexpress"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 15
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "redis" {
  name         = "redis-${count.index}"
  count        = 6
  machine_type = var.redis_vm_type
  tags         = ["ssh", "redis"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 50
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "nginx" {
  name         = "nginx-0"
  machine_type = var.nginx_vm_type
  tags         = ["ssh", "nginx"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "flask" {
  name         = "flask-${count.index}"
  count        = 5
  machine_type = var.flask_vm_type
  tags         = ["ssh", "flask"]

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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "portainer-server" {
  name         = "portainer-server-0"
  machine_type = "e2-medium"
  tags         = ["ssh", "portainer"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 15
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "test-server" {
  name         = "test-server-0"
  machine_type = var.test_vm_type
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "react-server" {
  name         = "react-server-0"
  machine_type = "e2-standard-2"
  tags         = ["ssh", "react"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
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
      mehrdad:ssh-rsa ${data.google_secret_manager_secret_version.vm-public-key-2.secret_data} kahe.mehrdad@gmail.com
    EOT
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
