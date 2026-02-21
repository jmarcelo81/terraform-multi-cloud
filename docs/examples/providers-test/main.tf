terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


data "aws_caller_identity" "me" {}

output "aws_account" {
  value = data.aws_caller_identity.me.account_id
}

provider "openstack" {
  cloud = "openstack-homelab"
}

data "openstack_networking_network_v2" "provider" {
  name = "provider"
}

output "openstack_provider_network_id" {
  value = data.openstack_networking_network_v2.provider.id
}
