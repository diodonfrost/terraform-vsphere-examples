# Configure vlan and network params

#### HTTP PORT CONFIG
# Create port frt with vlan
resource "vsphere_host_port_group" "http_port" {
  name                = var.http_network_params["label"]
  host_system_id      = data.vsphere_host.host.id
  virtual_switch_name = var.vswitch
  vlan_id             = var.http_network_params["vlan_id"]
  allow_promiscuous   = true
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

#### DB PORT CONFIG
# Create port db with vlan
resource "vsphere_host_port_group" "db_port" {
  name                = var.db_network_params["label"]
  host_system_id      = data.vsphere_host.host.id
  virtual_switch_name = var.vswitch
  vlan_id             = var.db_network_params["vlan_id"]
  allow_promiscuous   = true
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

