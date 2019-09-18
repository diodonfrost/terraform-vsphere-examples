#### POOL HTTP ####
#
# Create vm http
#

############ HTTP VM ############
#
#
resource "vsphere_virtual_machine" "http_vm" {
  count            = var.http_vm_desired_capacity
  name             = "${var.http_base_hostname}${count.index + 1}"
  num_cpus         = var.http_vm_params["vcpu"]
  memory           = var.http_vm_params["ram"]
  datastore_id     = data.vsphere_datastore.datastore_http.id
  host_system_id   = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  # Configure network interface
  network_interface {
    network_id = data.vsphere_network.network_http.id
  }

  disk {
    name = "${var.http_base_hostname}${count.index + 1}.vmdk"
    size = var.http_vm_params["disk_size"]
  }

  # Define template and customisation params
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.http_base_hostname}${count.index + 1}"
        domain    = var.http_network_params["domain"]
      }

      network_interface {
        ipv4_address    = "${var.http_network_params["base_address"]}${count.index + 10}"
        ipv4_netmask    = var.http_network_params["prefix_length"]
        dns_server_list = var.dns_servers
      }

      ipv4_gateway = var.http_network_params["gateway"]
    }
  }
  depends_on = [vsphere_host_port_group.http_port]
}

