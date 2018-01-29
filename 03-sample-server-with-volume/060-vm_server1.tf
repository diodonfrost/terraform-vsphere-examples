#### SERVER_ONE ####
#
# Create vm with template
#

resource "vsphere_virtual_machine" "server1" {
  name                   = "${var.server1_vm_params["hostname"]}"
  num_cpus               = "${var.server1_vm_params["vcpu"]}"
  memory                 = "${var.server1_vm_params["ram"]}"
  datastore_id           = "${data.vsphere_datastore.datastore.id}"
  host_system_id         = "${data.vsphere_host.host.id}"
  resource_pool_id       = "${data.vsphere_resource_pool.pool.id}"
  guest_id               = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type              = "${data.vsphere_virtual_machine.template.scsi_type}"

# Configure network interface
  network_interface {
    network_id           = "${data.vsphere_network.network.id}"
  }

# Configure Disk
  disk {
    name                 = "${var.server1_vm_params["hostname"]}.vmdk"
    size                 = "${var.server1_vm_params["disk_size"]}"
  }

  disk {
      name               = "disk-${var.server1_vm_params["hostname"]}.vmdk"
      size               = "${var.server1_vm_params["disk_size"]}"
      unit_number        = "1"
      thin_provisioned   = "true"
    }

# Define template and customisation params
  clone {
    template_uuid       = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name       = "${var.server1_vm_params["hostname"]}"
        domain          = "${var.server1_network_params["domain"]}"
      }

      network_interface {
        ipv4_address    = "${var.server1_network_params["ipv4_address"]}"
        ipv4_netmask    = "${var.server1_network_params["prefix_length"]}"
        dns_server_list = "${var.dns_servers}"
      }

      ipv4_gateway      = "${var.server1_network_params["gateway"]}"
    }
  }
  depends_on            = ["vsphere_host_port_group.network_port"]
}
