#### GLOBAL CONFIG DC AND HOST
# Define datacenter
data "vsphere_datacenter" "dc" {
  name = "${var.dc}"
}

# Exctrat data port vlan creation
data "vsphere_host" "host" {
  name          = "${var.host}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  # If you haven't resource pool, put "Resources" after cluster name
  name          = "${var.cluster}/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.server1_vm_params["disk_datastore"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.server1_network_params["label"]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
  depends_on    = ["vsphere_host_port_group.network_port"]
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template_image}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
