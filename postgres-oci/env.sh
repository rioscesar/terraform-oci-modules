#Enter Your Tenancy OCID
export TF_VAR_tenancy_ocid="Enter Your Tenancy OCID Here"
#Enter Your Compartment OCID
export TF_VAR_compartment_ocid="Enter Your Compartment OCID Here"
#Enter Your User OCID
export TF_VAR_user_ocid="Enter Your User OCID Here"
#Enter Your Fingerprint
export TF_VAR_fingerprint="fb:93:b0:6c:ac:f2:42:c7:97:00:43:82:f3:27:97:91"
#Enter Your Region
export TF_VAR_region="Enter Your Region Here"

export TF_VAR_image_ocid="Custom Image OCID"
export TF_VAR_instance_shape="VM.Standard1.1"

#Change following fields to point to correct keys
export TF_VAR_private_key_path="userdata/keys/APIkey.pem"
export TF_VAR_ssh_public_key=$(cat userdata/keys/ssh_key.pub)
export TF_VAR_ssh_authorized_private_key=$(cat userdata/keys/ssh_key.ssh)
