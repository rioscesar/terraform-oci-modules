resource "null_resource" "mean-stack-config" {
  count = "${var.instance_count}"
  provisioner "file" {
    connection {
      host = "${element(split(",", var.mean-stack-public-ip), count.index)}" 
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    source     = "userdata/"
    destination = "/tmp/"
  }
  
  provisioner "remote-exec" {
    connection {
      host="${element(split(",", var.mean-stack-public-ip), count.index)}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      "chmod +x /tmp/meanstack.sh",
      "sudo /tmp/meanstack.sh ",
    ]
  }
}
