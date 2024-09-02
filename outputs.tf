output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.subnet_ids
}

output "nat_ip" {
  description = "The external IP address of the NAT gateway"
  value       = module.vpc.nat_ip
}