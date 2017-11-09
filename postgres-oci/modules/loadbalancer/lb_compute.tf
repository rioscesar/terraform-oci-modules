resource "oci_load_balancer" "lb" {
  shape          = "${var.lb_shape}"
  compartment_id = "${var.compartment_ocid}"
  subnet_ids     = ["${var.lb_subnet_1}", "${var.lb_subnet_2}"]
  display_name   = "TF_LoadBalancer"
}

resource "oci_load_balancer_backendset" "lb-bes1" {
  name = "TF_Backendset"

  load_balancer_id = "${oci_load_balancer.lb.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${oci_load_balancer.lb.id}"
  name                     = "http"
  default_backend_set_name = "${oci_load_balancer_backendset.lb-bes1.id}"
  port                     = "8080"
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "lb-be" {
  load_balancer_id = "${oci_load_balancer.lb.id}"
  backendset_name  = "${oci_load_balancer_backendset.lb-bes1.id}"
  ip_address       = "${element(split(",", var.lb_backend_all_ip), count.index)}"
  count            = "${var.lb_backend_ip_count}"
  port             = "8080"
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}
