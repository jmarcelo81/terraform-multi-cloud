output "vm_id" {
  value = openstack_compute_instance_v2.vm.id
}

output "vm_fixed_ip" {
  value = openstack_compute_instance_v2.vm.access_ip_v4
}

output "floating_ip" {
  value = openstack_networking_floatingip_v2.fip.address
}

output "ssh_command" {
  value = "ssh -i ${path.module}/tf-lab-key.pem ubuntu@${openstack_networking_floatingip_v2.fip.address}"
}
