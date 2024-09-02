output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = google_compute_subnetwork.subnet[*].id
}

output "nat_ip" {
  description = "The external IP address of the NAT gateway"
  value       = google_compute_router_nat.nat.nat_ips
}