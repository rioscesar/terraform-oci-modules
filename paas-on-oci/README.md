# OCI Terraform Environment Automation 

#### *Disclaimer! This is not production level code. Should be treated as a resource on how to automate PaaS Java Cloud Service and Database Cloud Service using Terraform. 

## Modify the env.sh file to match your configurations to point to your cloud environment. 

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

export TF_VAR_user="cloud.admin"
export TF_VAR_password=""
export TF_VAR_domain="idcs-xxx"
export TF_VAR_tenancy="gse-xxx"
export TF_VAR_object_storage_user=""

#Change following fields to point to correct keys
export TF_VAR_private_key_path="userdata/APIkey.pem"
export TF_VAR_ssh_public_key=$(cat userdata/ssh_key.pub)
export TF_VAR_ssh_authorized_private_key=$(cat userdata/ssh_key.ssh)
```
  
## Missing directories:
  * userdata
    - APIkey.pem
    - APIkey_public.pem
    - test_ssh
    - test_ssh.pub

#### The userdata directory contains your APIkey.pem (logs you into your cloud account) as well as your public and private ssh keys you will use to log into your newly created instances. If you need help creating either of these take a look at Oracle's documentation: https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm.
  * Create the APIkey.pem file. 
  * Don't forget to also add your private and public ssh keys into the userdata directory.

###### terraform plan -out=plan.out
###### terraform apply plan.out

#### DESTROY EVERYTHING!

###### terraform destroy 
