output "master" {
  value = "${oci_core_instance.master.public_ip}"
}

output "master-private-ip" {
  value = "${oci_core_instance.master.private_ip}"
}

output "agents" {
  value = "${join(",", oci_core_instance.agent.*.public_ip)}"
}
