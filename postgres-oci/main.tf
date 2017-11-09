module "vcn" {
  source = "./modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
}

module "mean-stack" {
  source = "./modules/compute-instance"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  instance_name = "meanstack"
  subnets = "${module.vcn.subnet2_ocid},${module.vcn.subnet3_ocid}"
  instance_count = "${var.instance_count}"
  instance_shape = "${var.instance_shape}"
  image_ocid = "${var.image_ocid}"
}

module "mean-stack-config" {
  source = "./modules/mean-stack-config"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  mean-stack-public-ip = "${module.mean-stack.items_comma}"
  instance_count = "${var.instance_count}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
}

module "mean-stack-load-balancer" {
  source              = "./modules/loadbalancer"
  tenancy_ocid        = "${var.tenancy_ocid}"
  compartment_ocid    = "${var.compartment_ocid}"
  region              = "${var.region}"
  lb_subnet_1         = "${module.vcn.subnet2_ocid}"
  lb_subnet_2         = "${module.vcn.subnet3_ocid}"
  lb_shape            = "100Mbps"
  lb_backend_ip_count = "${var.instance_count}"
  lb_backend_all_ip   = "${module.mean-stack.items_comma}"
}


output "MEAN Stack URL" {
  value = "http://${module.mean-stack-load-balancer.lb_public_ip[0]}:8080"
}
