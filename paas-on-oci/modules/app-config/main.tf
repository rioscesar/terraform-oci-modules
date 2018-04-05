resource "null_resource" "config-scripts" {
  provisioner "file" {
    connection {
      host = "${var.public-ip}" 
      user = "${var.instance_user}"
      private_key = "${var.ssh_private_key}"
    }
    source      = "scripts/"
    destination = "/tmp/"
  }
}

resource "null_resource" "docker-config" {

  depends_on = ["null_resource.config-scripts"]
  
  provisioner "remote-exec" {
    connection {
      host= "${var.public-ip}"
      user = "${var.instance_user}"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      "chmod +x /tmp/install_docker.sh",	
      "sudo /tmp/install_docker.sh"
    ]
  }
}
