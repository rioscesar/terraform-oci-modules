module "vcn" {
  source = "./modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  dns_vcn = "tfvcn"
  vcn_display = "PuppetVCN"
}

module "puppet-compute" {
  source = "./modules/compute-instance"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  master_label = "puppet"
  agent_label = "db-server"
  subnet = "${module.vcn.subnet2_ocid}"
  instance_count = "${var.instance_count}"
  instance_shape = "${var.instance_shape}"
  image_ocid = "${var.image_ocid}"
  db_size = "${var.db_size}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  nfs_volume = "${var.nfs_volume}"
}

module "puppet-config" {
  source = "./modules/puppet-config"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  master-public-ip = "${module.puppet-compute.master}"
  master-private-ip = "${module.puppet-compute.master-private-ip}"
  agent-public-ips = "${module.puppet-compute.agents}"
  instance_count = "${var.instance_count}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  db_size = "${var.db_size}"
}

output "Master Public IP" {
  value = "${module.puppet-compute.master}"
}
output "Agent Public IP" {
  value = ["${module.puppet-compute.agents}"]
}
