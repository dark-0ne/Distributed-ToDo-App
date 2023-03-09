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
resource "google_compute_firewall" "allow-internal" {
  name = "allow-internal"
  allow {
    protocol = "all"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["10.0.1.0/24"]
  target_tags   = []
}

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

resource "google_compute_firewall" "mongodb-shard" {
  name = "allow-mongodb-shard"
  allow {
    ports    = ["16969"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["mongodb-shard"]
}

resource "google_compute_firewall" "mongodb-cfgsrv" {
  name = "allow-mongodb-cfgsrv"
  allow {
    ports    = ["18585"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["mongodb-cfgsrv"]
}

resource "google_compute_firewall" "mongodb-router" {
  name = "allow-mongodb-router"
  allow {
    ports    = ["16985"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["mongodb-router"]
}

resource "google_compute_firewall" "redis" {
  name = "allow-redis"
  allow {
    ports    = ["6379"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["redis"]
}

resource "google_compute_firewall" "nginx" {
  name = "allow-http"
  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }
  allow {
    ports    = ["80", "443"]
    protocol = "udp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nginx"]
}

resource "google_compute_firewall" "flask" {
  name = "allow-flask"
  allow {
    ports    = ["5000"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["flask"]
}

resource "google_compute_firewall" "portainer" {
  name = "allow-portainer"
  allow {
    ports    = ["8000", "9443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["130.231.0.0/16"]
  target_tags   = ["portainer"]
}
