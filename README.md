## Terraform introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Version used:
*   Terraform 0.11.2

## Openstack authentification
The vsphere provider is used to interact with the many resources supported by vsoere. The provider needs to be configured with the proper credentials before it can be used.

```
provider "vsphere" {
  user           = "my-litle-user"
  password       = "secret"
  vsphere_server = "my-vcenter.com"
}
```

## Getting Started

Before terraform apply you must download provider plugin:
```
terraform init
```

Display plan before apply manifest
```
terraform plan
```

Apply manifest
```
terraform apply
```

Destroy stack
```
terraform destroy
```

## Documentation
https://www.terraform.io/docs/providers/vsphere/index.html

https://github.com/terraform-providers/terraform-provider-vsphere
