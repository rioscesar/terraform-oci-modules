provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region="${var.region}"
}

provider "oraclepaas" {
  user              = "${var.user}"
  password          = "${var.password}"
  identity_domain   = "${var.domain}"
  database_endpoint = "https://dbaas.oraclecloud.com"
  java_endpoint     = "https://jaas.oraclecloud.com"
}
