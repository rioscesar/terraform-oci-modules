output "lb_public_ip" {
  value = ["${oci_load_balancer.lb.ip_addresses}"]
}
