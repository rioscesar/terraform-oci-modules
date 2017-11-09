variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "instance_shape" {}
variable "image_ocid" {}
variable "instance_name" {}
variable "MEAN_STACK" {
  default = "./userdata/meanstack.sh"
}

variable "instance_count" {}
variable "subnets" {}
