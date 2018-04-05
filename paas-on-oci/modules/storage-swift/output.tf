output "name" {
  value = "${oci_objectstorage_bucket.bucket.name}"
}

output "swift-password" {
  value = "${oci_identity_swift_password.swift.password}"
}
