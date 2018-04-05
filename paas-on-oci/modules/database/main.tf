resource "oci_database_db_system" "TFDBNode" {
  availability_domain = "${var.availability_domain}"
  compartment_id = "${var.compartment_ocid}"
  cpu_core_count = "${var.CPUCoreCount}"
  database_edition = "${var.DBEdition}"
  db_home {
    database {
      "admin_password" = "${var.DBAdminPassword}"
      "db_name" = "${var.DBName}"
      "character_set" = "${var.CharacterSet}"
      "ncharacter_set" = "${var.NCharacterSet}"
      "db_workload" = "${var.DBWorkload}"
      "pdb_name" = "${var.PDBName}"
    }
    db_version = "${var.DBVersion}"
    display_name = "${var.DBDisplayName}"
  }
  disk_redundancy = "${var.DBDiskRedundancy}"
  shape = "${var.DBNodeShape}"
  subnet_id = "${var.SubnetOCID}"
  ssh_public_keys = ["${var.ssh_public_key}"]
  display_name = "${var.DBNodeDisplayName}"
  domain = "${var.DBNodeDomainName}"
  hostname = "${var.DBNodeHostName}"
  data_storage_percentage = "${var.DataStorgePercent}"
  data_storage_size_in_gb = "${var.DataStorageSizeInGB}"
  license_model = "${var.LicenseModel}"
  node_count = "${var.NodeCount}"
}

resource "null_resource" "setup" {
  depends_on = ["oci_database_db_system.TFDBNode"]
  
  provisioner "file" {
    connection {
      host= "${data.oci_core_vnic.DBNodeVnic.public_ip_address}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    source = "scripts/"
    destination = "/tmp"
  }
}

resource "null_resource" "database-config" {
  depends_on = ["null_resource.setup"]

  provisioner "remote-exec" {
    connection {
      host= "${data.oci_core_vnic.DBNodeVnic.public_ip_address}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      "chmod +x /tmp/setup_db.sh",	
      "sudo /tmp/setup_db.sh"
    ]
  }
}
