resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  count         = length(var.subnet_cidrs)
  name          = "subnet-${count.index}"
  ip_cidr_range = var.subnet_cidrs[count.index]
  region        = var.region
  network       = google_compute_network.vpc.self_link
  project       = var.project_id

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = cidrsubnet(var.subnet_cidrs[count.index], 4, 1)
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = cidrsubnet(var.subnet_cidrs[count.index], 4, 2)
  }
}

resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.self_link
  project = var.project_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.vpc_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.vpc_name}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}