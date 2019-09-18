#### POOL DB ####
#
# Create vm dv
#

############ DB VM ############
#
#
resource "vsphere_virtual_machine" "db_vm" {
  count            = var.db_vm_desired_capacity
  name             = "${var.db_base_hostname}${count.index + 1}"
  num_cpus         = var.db_vm_params["vcpu"]
  memory           = var.db_vm_params["ram"]
  datastore_id     = data.vsphere_datastore.datastore_db.id
  host_system_id   = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  # Configure network interface
  network_interface {
    network_id = data.vsphere_network.network_db.id
  }

  disk {
    name = "${var.db_base_hostname}${count.index + 1}.vmdk"
    size = var.db_vm_params["disk_size"]
  }

  # Define template and customisation params
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.db_base_hostname}${count.index + 1}"
        domain    = var.db_network_params["domain"]
      }

      network_interface {
        ipv4_address    = "${var.db_network_params["base_address"]}${count.index + 10}"
        ipv4_netmask    = var.db_network_params["prefix_length"]
        dns_server_list = var.dns_servers
      }

      ipv4_gateway = var.db_network_params["gateway"]
    }
  }
  depends_on = [vsphere_host_port_group.db_port]
}

