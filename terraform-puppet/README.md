# Terraform Puppet example. 

#### *Disclaimer! This is not production level code. Should be treated as a resource on how to connect Puppet Enterprise with Terraform as well as automating NFS.*

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

export TF_VAR_image_ocid="Custom Image OCID"
export TF_VAR_instance_shape="VM.Standard1.4"

#Change following fields to point to correct keys
export TF_VAR_private_key_path="userdata/APIkey.pem"
export TF_VAR_ssh_public_key=$(cat userdata/ssh_key.pub)
export TF_VAR_ssh_authorized_private_key=$(cat userdata/ssh_key.ssh)
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

## You can try running this without oradb and installer (you still need userdata). What will happen is you will have a compute instance with a block volume and other instances connected to it through NFS. 

##### terraform plan -out=plan.out
##### terraform apply "plan.out"

#### DESTROY EVERYTHING!

##### terraform destroy 

## Things to consider when using this resource as is.
  * NFS file system is set to 50GB and Agent volumes are set to 100GB. You can modify these values on *vars.tf* but make sure to also modify *volume.layout* for the Agents and/or *master.layout* for the Master. 

#### Terraform works great if you have an architecture you want to build beforehand and then code to that standard. For that I recommend creating your infrastructure at least once before running any Terraform modules. The layout files used in this example were created using fdisk to partition the block volume attached to the instance. sfdisk --dump \<your volume location\> was then used to write what your partition looked like to a file.
  * fdisk \<your volume location\>
  * sfdisk -d \<your volume location\> > volume.layout

#### One last note: If you're familiar with Puppet then this might be common sense but deleting an agent using Terraform (chainging *instance_count* from 2 to 1) will delete the compute instace but will not remove the metadata that master has about it's agents. Before deleting an agent make sure you remove it from master and then you can remove it using Terraform. Information on how to delete an agent's metadata from master can be found here: https://puppet.com/docs/pe/2017.3/managing_nodes/adding_and_removing_nodes.html.
