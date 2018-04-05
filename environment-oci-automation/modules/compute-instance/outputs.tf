output "public-ip" {
  value = "${oci_core_instance.devops.public_ip}"
}
