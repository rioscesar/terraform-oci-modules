output "subnet1_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD1.id}"
}

output "subnet2_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD2.id}"
}

output "subnet3_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD3.id}"
}
