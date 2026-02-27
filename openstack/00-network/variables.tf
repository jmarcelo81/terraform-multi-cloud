variable "openstack_cloud" {
  description = "clouds.yaml entry name"
  type        = string
  default     = "openstack-homelab-terraform-lab"
}

variable "external_network_name" {
  description = "External network for floating IPs"
  type        = string
  default     = "provider"
}

variable "internal_network_name" {
  description = "Lab internal network name"
  type        = string
  default     = "tf-internal"
}

variable "internal_subnet_name" {
  description = "Lab internal subnet name"
  type        = string
  default     = "tf-internal-subnet"
}

variable "internal_cidr" {
  description = "CIDR for lab internal subnet"
  type        = string
  default     = "192.168.110.0/24"
}

variable "internal_gateway" {
  description = "Gateway IP for lab subnet"
  type        = string
  default     = "192.168.110.1"
}

variable "dns_nameservers" {
  description = "DNS servers for instances"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "router_name" {
  description = "Router name for lab"
  type        = string
  default     = "tf-router"
}

variable "vm_name" {
  description = "Instance name"
  type        = string
  default     = "tf-ubuntu-01"
}

variable "image_name" {
  description = "OpenStack image name"
  type        = string
  default     = "ubuntu-22.04"
}

variable "flavor_name" {
  description = "OpenStack flavor name"
  type        = string
  default     = "m1.standard"
}

variable "ssh_cidr" {
  description = "List of CIDRs allowed to SSH"
  type        = list(string)
}
