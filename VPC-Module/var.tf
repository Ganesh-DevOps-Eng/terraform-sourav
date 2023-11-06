variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "project_name" {
  default = "matelliocorp"
}
variable "az_count" {
  default = "2"
}

variable "rds_sg" {
  type    = set(string)
  default = []
}