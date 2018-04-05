############################# User Configuration ####################################

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "ssh_public_key" {}
variable "ssh_public_key_path" {}
variable "ssh_authorized_private_key" {}

variable "user" {}
variable "password" {}
variable "domain" {}
variable "tenancy" {}
variable "object_storage_user" {}

############################### Compute Configuration #################################

variable "compute_name" {
  default="DevOps-Instance"
}
variable "compute_label" {
  default="devops-instance"
}
variable "instance_shape" {
  default="VM.Standard1.2"
}
variable "image_ocid" {
  default="ocid1.image.oc1.iad.aaaaaaaaafmyat7i5s7ae3aylwtvmt7v4dw4yy2thgzaqlbjzoxngrjg54xq"
}
variable "instance_user" {
  default="ubuntu" 
}
variable "timeout" {
  default="60m" 
}
############################### PaaS Configuraton ###################################

variable "PaaSJCSName" {
  default="PaaSJCS"
}
variable "PaaSDBName" {
  default="PaaSDB"
}
variable "DBShape" {
  default="VM.Standard1.2"
}
variable "JCSShape" {
  default="VM.Standard2.1"
}
variable "sid" {
  default="ORCL"
}
variable "weblogic_pwd" {
  default="welcome1"
}

############################ VCN Configuration #######################################

variable "dns_vcn" {
  default="tfvcn"
}
variable "oraclevcn" {
  default="oraclevcn.com"
}
variable "vcn_display" {
  default="DevOpsVCN"
}
variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

############################# Compartment and Policies ###############################
variable "compartment_name" {
  default="PaaSandCompute"
}
variable "compartment_description" {
  default="JCS and Compute compartment"
}
variable "policy_name" {
  default="PaaSPolicy"
}
variable "policy_desc" {
  default="Allow PaaS to access OCI"
}

############################ Object Storage and Swift Password ##############################
variable "swift_password" {
  default="Ojbect Storage password for PaaS"
}
variable "bucket_name" {
  default="StorageBucket"
}

############################## Database Configuration ####################################

variable "DataStorgePercent" {
  default="40"
}
variable "DBNodeShape" {
    default = "VM.Standard1.1"
}
variable "CPUCoreCount" {
    default = "1"
}
variable "DBEdition" {
    default = "ENTERPRISE_EDITION"
}
variable "DBAdminPassword" {
    default = "BEstrO0ng_#11"
}
variable "DBName" {
    default = "aTFdb"
}
variable "DBVersion" {
    default = "12.1.0.2"
}
variable "DBDisplayName" {
    default = "MyTFDB"
}
variable "DBDiskRedundancy" {
    default = "HIGH"
}
variable "DBNodeDisplayName" {
    default = "MyTFDatabaseNode0"
}
variable "DBNodeHostName" {
    default = "myOracleDB"
}
variable "HostUserName" {
    default = "opc"
}
variable "NCharacterSet" {
  default = "AL16UTF16"
}
variable "CharacterSet" {
  default = "AL32UTF8"
}
variable "DBWorkload" {
  default = "OLTP"
}
variable "PDBName" {
  default = "pdbName"
}
variable "DataStorageSizeInGB" {
  default = "256"
}
variable "LicenseModel" {
  default = "LICENSE_INCLUDED"
}
variable "NodeCount" {
  default = "1"
}
