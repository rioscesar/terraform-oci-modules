# Terraform Puppet example. 

#### *Disclaimer! This is not production level code. Should be treated as a resource on how to connect Puppet Enterprise with Terraform as well as automating NFS.*

## Modify the env.sh file to match your configurations to point to your cloud. 

```#Enter Your Tenancy OCID
export TF_VAR_tenancy_ocid="Enter Your Tenancy OCID Here"
#Enter Your Compartment OCID
export TF_VAR_compartment_ocid="Enter Your Compartment OCID Here"
#Enter Your User OCID
export TF_VAR_user_ocid="Enter Your User OCID Here"
#Enter Your Fingerprint
export TF_VAR_fingerprint="Fingerprint Here"
#Enter Your Region
export TF_VAR_region="Enter Your Region Here"

export TF_VAR_image_ocid="Custom Image OCID"
export TF_VAR_instance_shape="VM.Standard1.4"

#Change following fields to point to correct keys
export TF_VAR_private_key_path="userdata/keys/APIkey.pem"
export TF_VAR_ssh_public_key=$(cat userdata/keys/ssh_key.pub)
export TF_VAR_ssh_authorized_private_key=$(cat userdata/keys/ssh_key.ssh)
```
  
## Missing directories:
  * oradb
  * installer
  * userdata
  
#### The installer directory should contain Puppet Enterpise https://puppet.com/download-puppet-enterprise.
  * Save the .tar file in the installer directory, Terraform will know what to do with it.
  
#### The oradb directory should contain Oracle's RDBMS binaries. You will have to create an Oracle account and then download them from https://edelivery.oracle.com. Current version being used on the puppet site.pp file is 12.1.0.2_Linux-x86-64 but with a few modifications you can also have 11 and 12.2.
  * You can download the required versions and put the zip files into the oradb directory. Puppet will know how to unzip them and install them.

#### The userdata directory contains your APIkey.pem (logs you into your cloud account) as well as your public and private ssh keys you will use to log into your newly created instances. If you need help creating either of these take a look at Oracle's documentation: https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm.
  * Create the APIkey.pem file. 
  * Don't forget to also add your private and public ssh keys into the userdata directory.
