output "items_comma" {
  value = "${join(",", oci_core_instance.compute_instance.*.public_ip)}"
}
