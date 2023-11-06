variable "username" {
  default = "admin"
}
variable "password" {
  default = "MyStrongPassword123"
}

variable "instance_type" {
  default = "t3.small"
}
#vpc module variable
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "project_name" {
  default = "matelliocorp"
}
variable "az_count" {
  default = "2"
}


variable "ami_id" {
  default = "ami-0df435f331839b2d6"
}
variable "DATABASE_NAME" {
  default = "store"
}