provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  project_id   = var.project_id
  region       = var.region
  vpc_name     = var.vpc_name
  subnet_cidrs = var.subnet_cidrs
}