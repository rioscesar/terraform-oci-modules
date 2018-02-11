resource "oci_core_instance" "master" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  image               = "${var.image_ocid}"
  shape               = "${var.instance_shape}"
  display_name = "${var.master_label}"

  create_vnic_details {
    subnet_id = "${var.subnet}"
    hostname_label = "${var.master_label}"
  }
  
  metadata = {
    "ssh_authorized_keys" = "${var.ssh_public_key}"
  }

  timeouts = {
    "create" = "60m"
  }
}

resource "oci_core_volume" "master-volume" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "master-block"
  size_in_gbs = "${var.nfs_volume}"
}

resource "oci_core_volume_attachment" "master-attach" {
  attachment_type = "iscsi"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.master.id}"
  volume_id = "${oci_core_volume.master-volume.id}"

  depends_on = ["oci_core_instance.master", "oci_core_volume.master-volume"]

  provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "30m"
        host = "${oci_core_instance.master.public_ip}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
	"sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.master-attach.iqn} -p ${oci_core_volume_attachment.master-attach.ipv4}:${oci_core_volume_attachment.master-attach.port}",
        "sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.master-attach.iqn} -n node.startup -v automatic",
	"echo sudo iscsiadm -m node -T ${oci_core_volume_attachment.master-attach.iqn} -p ${oci_core_volume_attachment.master-attach.ipv4}:${oci_core_volume_attachment.master-attach.port} -l >> ~/.bashrc"
      ]
    }
}

resource "oci_core_instance" "agent" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  image               = "${var.image_ocid}"
  shape               = "${var.instance_shape}"
  count               = "${var.instance_count}"
  display_name = "${var.agent_label}-${count.index + 1}"
  
  create_vnic_details {
    subnet_id = "${var.subnet}"
    hostname_label = "${var.agent_label}-${count.index + 1}"
  }

  metadata = {
    "ssh_authorized_keys" = "${var.ssh_public_key}"
  }

  timeouts = {
    "create" = "60m"
  }
}

resource "oci_core_volume" "agent-volume" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "agent-block"
  size_in_gbs = "${var.db_size}"
  count = "${var.instance_count}"
}

resource "oci_core_volume_attachment" "agent-attach" {
  attachment_type = "iscsi"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.agent.*.id[count.index]}"
  volume_id = "${oci_core_volume.agent-volume.*.id[count.index]}"
  count = "${var.instance_count}"
  depends_on = ["oci_core_instance.agent", "oci_core_volume.agent-volume"]
}

resource "null_resource" "agent-mount" {
  count = "${var.instance_count}"
  depends_on = ["oci_core_volume_attachment.agent-attach"]

  provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "30m"
        host = "${oci_core_instance.agent.*.public_ip[count.index]}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
	"sudo iscsiadm -m node -o new -T ${oci_core_volume_attachment.agent-attach.*.iqn[count.index]} -p ${oci_core_volume_attachment.agent-attach.*.ipv4[count.index]}:${oci_core_volume_attachment.agent-attach.*.port[count.index]}",
        "sudo iscsiadm -m node -o update -T ${oci_core_volume_attachment.agent-attach.*.iqn[count.index]} -n node.startup -v automatic",
	"echo sudo iscsiadm -m node -T ${oci_core_volume_attachment.agent-attach.*.iqn[count.index]} -p ${oci_core_volume_attachment.agent-attach.*.ipv4[count.index]}:${oci_core_volume_attachment.agent-attach.*.port[count.index]} -l >> ~/.bashrc"
      ]
    }
}
