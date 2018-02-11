variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "ssh_public_key" {}
variable "instance_shape" {}
variable "image_ocid" {}
variable "ssh_authorized_private_key" {}
variable "db_size" {
  default="100"
}
variable "nfs_volume" {
  default="50"
}
variable "instance_count" {
  default="1"
}
