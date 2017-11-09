resource "oci_core_instance" "compute_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index + 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "TF_Instance-${count.index + 1}"
  image               = "${var.image_ocid}"
  shape               = "${var.instance_shape}"
  subnet_id           = "${element(split(",", var.subnets), count.index)}"
  count               = "${var.instance_count}"

  metadata = {
    "ssh_authorized_keys" = "${var.ssh_public_key}"
  }

  timeouts = {
    "create" = "60m"
  }
}
