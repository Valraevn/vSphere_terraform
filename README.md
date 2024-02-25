# vSphere_terraform
Using terraform with vSphere

A Terraform configuration file that defines a set of resources for managing a VM in a vSphere environment. 

The main.tf is where the action happens, 'terraform apply' will prompt for input according to the contents of variables.tf. 'terraform apply -var-file=creds.tfvars' will apply the contents of creds.tfvars to the prompts accordingly.

Provider Configuration:
Specifies the vSphere provider with the necessary connection details such as user, password, and server.

Data Sources:
vsphere_datacenter: Retrieves information about the vSphere datacenter with the specified name.
vsphere_datastore: Retrieves information about the vSphere datastore with the specified name and associated with the previously retrieved datacenter.
vsphere_compute_cluster: Retrieves information about the vSphere compute cluster with the specified name and associated with the previously retrieved datacenter.
vsphere_network: Retrieves information about the vSphere network with the specified name and associated with the previously retrieved datacenter.

Resource:
vsphere_virtual_machine: Defines a virtual machine named "Ubuntu" with various configurations such as CPU, memory, guest ID, network interface, disk, and CD-ROM. The VM is associated with the previously retrieved compute cluster, datastore, and network.

Null Resource:
null_resource: Used for triggers and local-exec provisioners. It depends on the completion of the VM creation and triggers a local command (in this case, echoing a message) when the VM is successfully created.

The provided configuration creates a virtual machine in a vSphere environment with specified settings and triggers a local message when the VM is created.

Note: If installing ESXi on a P/E core setup add the following to the boot process:
cpuUniformityHardCheckPanic=FALSE
and then as a peraament change:
esxcli system settings kernel set -s cpuUniformityHardCheckPanic -v FALSE
