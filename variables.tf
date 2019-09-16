
variable "name" {
  default = "nfs"
}
variable "storage_subnet_ids" {
  description = "Existing subnet IDs to deploy NFS server to"
}

variable "instance_type" {
  default = "m5.large"
}

variable "instance_ami_id" {
  default = "ami-0bbc25e23a7640b9b"
}

variable "key_pair" {
  description = "Name of your key-pair in aws"
}

variable "ansible_provision_file" {
  default     = "./assets/nfs_setup.yml"
  description = "Path to ansible playbook file"
}

variable "ebs_volume_id" {
  description = "Existing EBS volume ID to use as NFS"
}

variable "region" {
  default = "eu-west-1"
}

variable "private_cidr_blocks" {
  type        = "list"
  description = "CIDR blocks allowed to connect to the NFS server"
}

variable "storage_cidr_blocks" {
  type        = "list"
  description = "CIDR blocks to deploy NFS server and Load Balancer"
}

variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
}

variable "zone_name" {
  description = "Route 53 Hosted Zone Name"
}

variable "vpc_id" {
  description = "Existing vpc id (required for security groups)"
}

variable "tags" {
  type = "map"

  default = {
    business-unit = "Platforms"
    application   = "analytical-platform"
    is-production = true
    owner         = "analytical-platform:analytics-platform-tech@digital.justice.gov.uk"
  }
}
