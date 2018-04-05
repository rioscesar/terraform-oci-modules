module "compartment_policies" {
  source = "./modules/cpolicies"
  name = "${var.compartment_name}"
  description = "${var.compartment_description}"
  tenancy_ocid = "${var.tenancy_ocid}"
  policy_name = "${var.policy_name}"
  policy_desc = "${var.policy_desc}"
}

module "object_storage" {
  source = "./modules/storage-swift"
  swift_description = "${var.swift_password}"
  user_id = "${var.user_ocid}"
  bucket_name = "${var.bucket_name}"
  compartment_id = "${module.compartment_policies.compartment_ocid}"
}

module "vcn" {
  source = "./modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${module.compartment_policies.compartment_ocid}"
  dns_vcn = "${var.dns_vcn}"
  vcn_display = "${var.vcn_display}"
  vpc-cidr = "${var.vpc-cidr}"
}

module "paas" {
  source = "./modules/paas"
  user = "${var.user}"
  password = "${var.password}"
  domain = "${var.domain}"
  subnet = "${module.vcn.subnet3_ocid}"
  region = "${var.region}"
  tenancy_ocid = "${var.tenancy_ocid}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
  PaaSDBName = "${var.PaaSDBName}"
  object_storage_user = "${var.object_storage_user}"
  swift_password = "${module.object_storage.swift-password}"
  PaaSJCSName = "${var.PaaSJCSName}"
  JCSShape = "${var.JCSShape}"
  tenancy = "${var.tenancy}"
  bucket = "${module.object_storage.name}"
  sid = "${var.sid}"
  DBPassword = "${var.DBAdminPassword}"
  DBShape = "${var.DBShape}"
  weblogic_pwd = "${var.weblogic_pwd}"
  
  availability_domain = "${module.vcn.subnet3_ad}"
}

module "compute" {
  source = "./modules/compute-instance"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${module.compartment_policies.compartment_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  instance_shape = "${var.instance_shape}"
  image_ocid = "${var.image_ocid}"
  subnet = "${module.vcn.subnet1_ocid}"
  name = "${var.compute_name}"
  label = "${var.compute_label}"
  availability_domain = "${module.vcn.subnet1_ad}"
  timeout = "${var.timeout}"
}

module "database" {
  source = "./modules/database"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${module.compartment_policies.compartment_ocid}"
  availability_domain = "${module.vcn.subnet1_ad}"
  SubnetOCID = "${module.vcn.subnet1_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  DBNodeDomainName = "${module.vcn.subnet1_label}.${var.dns_vcn}.${var.oraclevcn}"
  DataStorgePercent = "${var.DataStorgePercent}"
  DBNodeShape = "${var.DBNodeShape}"
  CPUCoreCount = "${var.CPUCoreCount}"
  DBEdition = "${var.DBEdition}"
  DBAdminPassword = "${var.DBAdminPassword}"
  DBName = "${var.DBName}"
  DBVersion = "${var.DBVersion}"
  DBDisplayName = "${var.DBDisplayName}"
  DBDiskRedundancy = "${var.DBDiskRedundancy}"
  DBNodeDisplayName = "${var.DBNodeDisplayName}"
  DBNodeHostName = "${var.DBNodeHostName}"
  HostUserName = "${var.HostUserName}"
  NCharacterSet = "${var.NCharacterSet}"
  CharacterSet = "${var.CharacterSet}"
  DBWorkload = "${var.DBWorkload}"
  PDBName = "${var.PDBName}"
  DataStorageSizeInGB = "${var.DataStorageSizeInGB}"
  LicenseModel = "${var.LicenseModel}"
  NodeCount = "${var.NodeCount}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
}

module "app-config" {
  source = "./modules/app-config"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${module.compartment_policies.compartment_ocid}"
  public-ip = "${module.compute.public-ip}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  instance_user = "${var.instance_user}"
}

output "Compute Public IP" {
  value = "${module.compute.public-ip}"
}

output "DB Public IP" {
  value = "${module.database.DBNodePublicIP}"
}

output "Swift Password" {
  value = "${module.object_storage.swift-password}"
}
