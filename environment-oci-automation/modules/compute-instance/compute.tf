resource "oci_core_instance" "devops" {
  availability_domain = "${var.availability_domain}"
  compartment_id      = "${var.compartment_ocid}"
  image               = "${var.image_ocid}"
  shape               = "${var.instance_shape}"
  display_name = "${var.name}"

  create_vnic_details {
    subnet_id = "${var.subnet}"
    hostname_label = "${var.label}"
  }
  
  metadata = {
    "ssh_authorized_keys" = "${var.ssh_public_key}"
  }

  timeouts = {
    "create" = "${var.timeout}"
  }
}

