data "oci_objectstorage_namespace" "t" {
}

resource "oci_objectstorage_bucket" "bucket" {
  compartment_id = "${var.compartment_id}"
  name = "${var.bucket_name}"
  namespace = "${data.oci_objectstorage_namespace.t.namespace}"
}

resource "oci_identity_swift_password" "swift" {
	description = "${var.swift_description}"
	user_id = "${var.user_id}"
}
