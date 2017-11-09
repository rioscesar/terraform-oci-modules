# Terraform-OCI-Workshop

## This will deploy a two virtual machines with a load balancer on Oracle Cloud Infrastructure using Terraform

# Software Requirements

To run this you must have installed the Terraform binary (at least 0.9.x) and configured it per instruction.

You must also have installed the Oracle Cloud Infrastructure Terraform provider.

You will also, of course, need access to an Oracle Cloud Infrastructure (OCI) account. If you do not have access, you can request a free trial. To learn more about Oracle OCI, read the Getting Started guide.

# Environment Requirements

If you are following along with the workshop Terraform can be installed from install_terraform.sh.

Otherwise follow all instructions for installing the Terraform and Oracle Cloud Infrastructure Provider executables.

https://github.com/oracle/terraform-provider-oci


# Running the Sample

(1) The env.sh file needs to be updated with your tenancy specific information
(2) The sample keys provided here 'ssh_authorized_keys.pem' and 'ssh_authorized_keys.pub' are just for illustration purposes. Those are dummy keys - replace with your actual working keys with the same file name for the keys.

Once you understand the code, have all the software requirements, and have satisfied the environmental requirements you can build your environment.

The first step is to parse all the modules by typing terraform get. This will build out a .terraform directory in your project root. This needs to be done only once.

The next step is to run terraform plan from the command line to generate an execution plan. Examine this plan to see what will be built and that there are no errors.

If you are satisfied, you can build the configuration by typing terraform apply. This will build all of the dependencies and construct an environment to match the project. I have seen some instances where the apply will fail midway through but the resolution is simply to type terraform apply again and the configuration will complete. Remember that terraform is indepotent so you can run apply as many times as you want and Terraform will sync the config for you.

Note that Terraform generates a terraform.tfstate and terraform.tfstate.backup file which manage the state of your environment. These files should not be hand edited.

If you want to tear down your environment, you can do that by running terraform destroy

Commands:

[opc@orchestration demo]$	. ./env.sh

[opc@orchestration demo]$	terraform plan

[opc@orchestration demo]$	terraform apply

[opc@orchestration demo]$	terraform destroy
