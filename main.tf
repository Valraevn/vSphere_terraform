provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Host"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "Ubuntu"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "ubuntu64Guest"
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 16
  }
  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = "/datastore1/isos/ubuntu.ova"
  }
}
# Add a null_resource to trigger the destruction of the VM
resource "null_resource" "destroy_vm" {
  depends_on = [vsphere_virtual_machine.vm]

  triggers = {
    vm_id = vsphere_virtual_machine.vm.id
  }

  provisioner "local-exec" {
    command = "echo 'VM destruction triggered'"
    # You can add additional commands here if needed
  }
}
