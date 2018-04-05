output "subnet1_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD1.id}"
}

output "subnet2_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD2.id}"
}

output "subnet2_label" {
  value = "${oci_core_subnet.TF_Public_SubnetAD2.dns_label}"
}

output "subnet1_label" {
  value = "${oci_core_subnet.TF_Public_SubnetAD1.dns_label}"
}

output "subnet3_label" {
  value = "${oci_core_subnet.TF_Public_SubnetAD3.dns_label}"
}

output "subnet2_ad" {
  value = "${oci_core_subnet.TF_Public_SubnetAD2.availability_domain}"
}

output "subnet1_ad" {
  value = "${oci_core_subnet.TF_Public_SubnetAD1.availability_domain}"
}

output "subnet3_ad" {
  value = "${oci_core_subnet.TF_Public_SubnetAD3.availability_domain}"
}

output "subnet3_ocid" {
  value = "${oci_core_subnet.TF_Public_SubnetAD3.id}"
}
