#resource "null_resource" "master-config" {
#  provisioner "file" {
#    connection {
#      host = "${var.master-public-ip}" 
#      user = "opc"
#      private_key = "${var.ssh_private_key}"
#    }
#    source     = "installer/"
#    destination = "/tmp/"
#  }

  provisioner "file" {
    connection {
      host = "${var.master-public-ip}" 
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    source     = "scripts/"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    connection {
      host= "${var.master-public-ip}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      #"chmod +x /tmp/puppet.sh",
      #"chmod +x /tmp/update_agent.sh",
      "chmod +x /tmp/nfs.sh",
      "sudo /tmp/nfs.sh"
      #, "sudo /tmp/puppet.sh",
      #"for ((n=0;n<2;n++)); do sudo /tmp/update_agent.sh; done"
    ]
  }
}

resource "null_resource" "agent-config" {
  depends_on = ["null_resource.master-config"]
  count = "${var.instance_count}"

  provisioner "file" {
    connection {
      host = "${element(split(",", var.agent-public-ips), count.index)}" 
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    source     = "scripts/"
    destination = "/tmp/"
  }
  
  provisioner "remote-exec" {
    connection {
      host = "${element(split(",", var.agent-public-ips), count.index)}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      #"chmod +x /tmp/agent.sh",
      "chmod +x /tmp/nfs-client.sh",
      "chmod +x /tmp/partition.sh",
      "chmod +x /tmp/mount.sh",
      "sudo /tmp/nfs-client.sh",
      "sudo /tmp/mount.sh",
      "sudo mount -t nfs ${var.master-private-ip}:/mnt/nfs/ /nfs/"
      #, "sudo /tmp/agent.sh"
    ]
  }
}

#resource "null_resource" "biemond-oradb" {
#  depends_on = ["null_resource.agent-config"]

#  provisioner "file" {
#    connection {
#      host = "${var.master-public-ip}"
#      user = "opc"
#      private_key = "${var.ssh_private_key}"
#    }
#    source     = "oradb/"
#    destination = "/mnt/nfs/"
#  }
  
#  provisioner "remote-exec" {
#    connection {
#      host = "${var.master-public-ip}"
#      user = "opc"
#      private_key = "${var.ssh_private_key}"
#    }
    
#    inline = [
#      "chmod +x /tmp/install_db.sh",
#      "sudo /tmp/install_db.sh",
#      "sudo mv /tmp/site.pp /etc/puppetlabs/code/environments/production/manifests/"
#    ]
#  }
#}

#resource "null_resource" "oradb-install" {
#  depends_on = ["null_resource.biemond-oradb", "null_resource.agent-config"]
#  count = "${var.instance_count}"

  
  
#  provisioner "remote-exec" {
#    connection {
#      host = "${element(split(",", var.agent-public-ips), count.index)}"
#      user = "opc"
#      private_key = "${var.ssh_private_key}"
#    }
    
#    inline = [
#      "chmod +x /tmp/update_agent.sh",
#      "sudo /tmp/update_agent.sh"
#    ]
#  }
#}
