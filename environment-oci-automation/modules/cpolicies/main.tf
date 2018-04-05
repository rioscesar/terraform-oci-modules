resource "oci_identity_compartment" "t" {
  name = "${var.name}"
  description = "${var.description}"
}

resource "oci_identity_policy" "t" {
  name = "${var.policy_name}"
  description = "${var.policy_desc}"
  compartment_id = "${var.tenancy_ocid}"
  statements = [
    "Allow service PSM to inspect vcns in compartment ${oci_identity_compartment.t.name}",
    "Allow service PSM to use subnets in compartment ${oci_identity_compartment.t.name}",
    "Allow service PSM to use vnics in compartment ${oci_identity_compartment.t.name}",
    "Allow service PSM to manage security-lists in compartment ${oci_identity_compartment.t.name}"
  ]
}
