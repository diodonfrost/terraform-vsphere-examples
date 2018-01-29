# How to

### Requirement

Before to launch terraform apply, you must set authentification params in 060-vm_basic.tf:
```
provider "vsphere" {
  # If you use a domain set your login like this "MyDomain\\MyUser"
  user           = "intra\\username"
  password       = "secret"
  vsphere_server = "my-little-vcenter-or-esxi-dnsname"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}
```

You must have already a template on vmware with network port "VM Network"

### Stack creation

```
terraform apply
```

This script will be create:
  - 1 vm

### Delete stack

```
terraform destroy
```
