# How to

### Requirement

Before to launch terraform apply, you must set authentification params in 00-variables.tf:
```
provider "vsphere" {
  user           = ""
  password       = ""
  vsphere_server = ""
}

variable "template_image" {
  default = ""
}

#### DC AND CLUSTER
# Set vpshere datacenter
variable "datacenter" {
  default = ""
}

# Set cluster where you want deploy your vm
variable "cluster" {
  default = ""
}

# Set host where you want deploy your vm
variable "host" {
  default = ""
}

variable "http_vm_params" {
  default = {
    ...
    disk_datastore = ""
    ...
  }
}

variable "db_vm_params" {
  default = {
    ...
    disk_datastore = ""
    ...
  }
}
```

### Stack creation

```
terraform apply
```

This script will be create:
  - 2 network port
  - 2 vlan
  - 2 vm http
  - 3 vm db

### Delete stack

```
terraform destroy
```
