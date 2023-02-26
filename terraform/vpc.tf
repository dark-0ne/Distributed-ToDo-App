# Setup VPC and subnet
resource "google_compute_network" "vpc_network" {
  name                    = "todo-app-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "todo-app-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
}

# Setup firewall rules
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "mongo" {
  name = "allow-mongodb"
  allow {
    ports    = ["16969"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["mongo"]
}
