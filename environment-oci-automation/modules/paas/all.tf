resource "oraclepaas_database_service_instance" "database" {
  name        = "${var.PaaSDBName}"
  description = "Created by Terraform"

  edition            = "EE_EP"
  version            = "12.2.0.1"
  subscription_type  = "HOURLY"

  ssh_public_key = "${join(" ",slice(split(" ",file("${var.ssh_public_key_path}")),0,2))}"

  # OCI Settings
  region              = "${var.region}"
  availability_domain = "${var.availability_domain}"
  subnet              = "${var.subnet}"
  shape               = "${var.DBShape}"

  database_configuration {
    admin_password     = "${var.DBPassword}"
    backup_destination = "BOTH"
    sid                = "${var.sid}"
    usable_storage     = 50
  }

  backups {
    cloud_storage_container = "https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/StorageBucket"
    cloud_storage_username  = "${var.object_storage_user}"
    cloud_storage_password  = "${var.swift_password}"
  } 
}

resource "oraclepaas_java_service_instance" "jcs" {
  name        = "${var.PaaSJCSName}"
  description = "Created by Terraform"

  edition              = "EE"
  service_version      = "12cRelease212"
  metering_frequency   = "HOURLY"
  #enable_admin_console = true

  force_delete           = true // force delete on destroy

  ssh_public_key = "${join(" ",slice(split(" ",file("${var.ssh_public_key_path}")),0,2))}"

  # OCI Settings
  region              = "${var.region}"
  # todo: get this from the subnet that is being used
  availability_domain = "${var.availability_domain}"
  subnet              = "${var.subnet}"

  weblogic_server {
    shape = "${var.JCSShape}"

    # managed_servers {
    #   server_count = 1
    # }

    admin {
      username = "weblogic"
      password = "${var.weblogic_pwd}"
    }

    database {
      name     = "${oraclepaas_database_service_instance.database.name}"
      username = "sys"
      password = "${oraclepaas_database_service_instance.database.database_configuration.0.admin_password}"
    }
  }

  # oracle_traffic_director {
  #   shape = "VM.Standard2.1"

  #   listener {
  #     port         = 8080
  #     secured_port = 8081
  #   }

  #   admin {
  #     username = "weblogic"
  #     password = "Weblogic_1"
  #   }
  # }

  backups {
    cloud_storage_container = "https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/StorageBucket"
    cloud_storage_username  = "${var.object_storage_user}"
    cloud_storage_password  = "${var.swift_password}"
  } 

}
