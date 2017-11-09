variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "instance_count" {
  default="2"
}
variable "ssh_public_key" {}
variable "instance_shape" {}
variable "image_ocid" {}
variable "ssh_authorized_private_key" {}
