<img src="https://camo.githubusercontent.com/0b1b56c6d6d890ae7f2bbafc65df8f72afdad1bb3ca28057114bd2300deddc78/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f5465727261666f726d2d3642343242433f7374796c653d666f722d7468652d6261646765266c6f676f3d7465727261666f726d266c6f676f436f6c6f723d7768697465">
<img scr="https://camo.githubusercontent.com/bf47c7bd93a62f058fedcbe85fb11f2c4345621d3beba6587ca89a6b6d62f5c8/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f564d776172652d3233316632303f7374796c653d666f722d7468652d6261646765266c6f676f3d564d77617265266c6f676f436f6c6f723d7768697465">

# vSphere_terraform
Using terraform with vSphere

A Terraform configuration file that defines a set of resources for managing a VM in a vSphere environment. 

The main.tf is where the action happens, 'terraform apply' will prompt for input according to the contents of variables.tf. 'terraform apply -var-file=creds.tfvars' will apply the contents of creds.tfvars to the prompts accordingly. You can also rename creds.tfvars to variables.auto.tfvars for terraform to auto-apply these variables.

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

and then as a permanent change run the following in shell: 
esxcli system settings kernel set -s cpuUniformityHardCheckPanic -v FALSE

if 13gen of higher also run this: 
esxcli system settings kernel set -s ignoreMsrFaults -v TRUE
