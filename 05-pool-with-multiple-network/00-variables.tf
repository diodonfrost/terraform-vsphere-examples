# Configure the VMware vSphere Provider
# You can use vcenter login params or simply host esxi login params
provider "vsphere" {
  # If you use a domain set your login like this "MyDomain\\MyUser"
  user           = "intra\\username"
  password       = "secret"
  vsphere_server = "vcenter.com"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

#### TEMPLATES

# You must add template in vsphere before use it
variable "template_image" {
  default = "centos-7-template-esxi"
}

#### DC AND CLUSTER
# Set vpshere datacenter
variable "dc" {
  default = "my-litle-datacenter"
}

# Set cluster where you want deploy your vm
variable "cluster" {
  default = "my-litle-cluster"
}

# Set host where you want deploy your vm
variable "host" {
  default = "my-litle-host"
}

#### GLOBAL NETWORK PARAMS
# Virtual switch used
variable "vswitch" {
  default = "vSwitch0"
}

variable "dns_servers" {
  default = ["8.8.8.8", "8.8.4.4"]
}

#### PARAMS HTTP INSTANCES #####################################
#
#
#
variable "http_vm_params" {
  default = {
    vcpu = "2"
    ram  = "4096"
    # You can't set a datastore name with interspace
    disk_datastore = "datastore_test"
    disk_size      = "15"
  }
}

variable "http_network_params" {
  default = {
    domain        = "test.local"
    label         = "http_network"
    vlan_id       = "1"
    base_address  = "192.168.1."
    prefix_length = "24"
    gateway       = "192.168.1.254"
  }
}

# Define the root hostname of http instance
# The root is incrementing for each instance create
# e.g: a root name with "frt0" will give:
# frt01 for the first instance
# ftp02 for the seconde instance etc...
#
variable "http_base_hostname" {
  default = "frt0"
}

# Set number of http instances
# WARNING CHANGING THIS VALUE ON STACK ALREADY CREATE WILL BE REMOVE AND RE-CREATE ALL INSTANCES
variable "http_vm_desired_capacity" {
  default = "2"
}

#### PARAMS DB INSTANCES #######################################
#
#
#
variable "db_vm_params" {
  default = {
    vcpu = "2"
    ram  = "2048"
    # You can't set a datastore name with interspace
    disk_datastore = "datastore_test"
    disk_size      = "15"
  }
}

variable "db_network_params" {
  default = {
    domain        = "test.local"
    label         = "db_network"
    vlan_id       = "2"
    base_address  = "192.168.2."
    prefix_length = "24"
    gateway       = "192.168.2.254"
  }
}

# Define the root hostname of bdd instance
# The root is incrementing for each instance create
# e.g: a root name with "bdd0" will give:
# bdd01 for the first instance
# bdd02 for the seconde instance etc...
#
variable "db_base_hostname" {
  default = "bdd0"
}

# Set number of db instances
# WARNING CHANGING THIS VALUE ON STACK ALREADY CREATE WILL BE REMOVE AND RE-CREATE ALL INSTANCES
variable "db_vm_desired_capacity" {
  default = "3"
}

