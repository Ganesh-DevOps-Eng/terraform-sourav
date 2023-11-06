provider "aws" {
  region = var.region
}

resource "aws_s3_object" "env_file" {
  bucket = var.s3_location
  key    = "web-app/.env"
  source = ".env"
  etag = "force-update"
}

module "RDS-Module" {
  source            = "./RDS-Module"
  vpc_cidr_block    = var.vpc_cidr_block
  project_name      = var.project_name
  az_count          = var.az_count
  username          = var.username
  password          = var.password
  instance_type     = var.instance_type
 
  ami_id            = var.ami_id
  
  DATABASE_NAME     = var.DATABASE_NAME

}

module "EB-module" {
  source = "./EB-module"
  eb_solution_stack = var.eb_solution_stack
  project_name = var.project_name
  instance_type = var.instance_type
}