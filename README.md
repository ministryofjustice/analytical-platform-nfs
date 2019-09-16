# Analytical Platform NFS
Terraform Module to provide storage solution (NFS)

Provisions an NFS server using a provided EBS volume ID.

## Usage

```hcl-terraform
module "nfs" {
  source = "github.com/ministryofjustice/analytical-platform-nfs"

  vpc_id              = "vpc-zy98vu54"
  storage_subnet_ids  = ["subnet-560g045hs5f0e6d93"]
  storage_cidr_blocks = ["192.168.20.0/24"]
  private_cidr_blocks = ["192.168.10.0/24", "192.168.14.0/24", "192.168.18.0/24"]
  key_pair            = "ec2-key-pair-name"
  zone_name           = "LE5W11KSLFJV9"
  ebs_volume_id       = "vol-0bad3a7b3ll5e5311"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc\_id | The VPC ID for where the NFS Server will be deployed. | string | `""` | yes |
| storage\_subnet\_ids | The Subnet IDs for where the NFS Server will be deployed. | list(string) | `[]` | yes |
| storage\_cidr\_blocks | The CIDR blocks for where the NFS Server will be deployed. | list(string) | `[]` | yes |
| private\_cidr\_blocks | The CIDR blocks for where the NFS Server will be accessed from. | list(string) | `[]` | yes |
| key\_pair | The key pair name in AWS EC2 to be assigned to the NFS server | string | `""` | yes |
| zone\_name | The Hosted Zone name to resolve nfs.zone_name  | string | `""` | yes |
| ebs\_volume\_id | The EBS Volume ID to use for NFS Storage  | string | `""` | yes |
| name | Variable used to name various resources within the module  | string | `"nfs"` | no |
| instance\_type | EC2 instance type  | string | `"m5.large"` | no |
| instance\_ami\_id | EC2 AMI ID  | string | `"ami-0bbc25e23a7640b9b"` | no |
