# ── External Network (data source) ───────────────────────────────────────────

data "openstack_networking_network_v2" "external" {
  name = var.external_network_name
}

# ── Internal Network + Subnet ─────────────────────────────────────────────────

resource "openstack_networking_network_v2" "internal" {
  name           = var.internal_network_name
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "internal" {
  name            = var.internal_subnet_name
  network_id      = openstack_networking_network_v2.internal.id
  cidr            = var.internal_cidr
  gateway_ip      = var.internal_gateway
  ip_version      = 4
  enable_dhcp     = true
  dns_nameservers = var.dns_nameservers
}

# ── Router ────────────────────────────────────────────────────────────────────

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

resource "openstack_networking_router_interface_v2" "router_int" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.internal.id
}

# ── Security Group ────────────────────────────────────────────────────────────

resource "openstack_networking_secgroup_v2" "ssh_sg" {
  name        = "tf-ssh-sg"
  description = "Allow SSH from home IP only; allow all egress"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_in" {
  for_each = toset(var.ssh_cidr)

  security_group_id = openstack_networking_secgroup_v2.ssh_sg.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = each.value
}

# ── SSH Key Pair ──────────────────────────────────────────────────────────────

resource "tls_private_key" "lab_key" {
  algorithm = "ED25519"
}

resource "openstack_compute_keypair_v2" "lab_keypair" {
  name       = "tf-lab-key"
  public_key = tls_private_key.lab_key.public_key_openssh
}

resource "local_sensitive_file" "lab_private_key" {
  filename        = "${path.module}/tf-lab-key.pem"
  content         = tls_private_key.lab_key.private_key_openssh
  file_permission = "0600"
}

# ── VM Port (explicit, for reliable FIP association) ──────────────────────────

resource "openstack_networking_port_v2" "vm_port" {
  name           = "${var.vm_name}-port"
  network_id     = openstack_networking_network_v2.internal.id
  admin_state_up = true

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.internal.id
  }

  security_group_ids = [openstack_networking_secgroup_v2.ssh_sg.id]

  depends_on = [openstack_networking_subnet_v2.internal]
}

# ── VM ────────────────────────────────────────────────────────────────────────

resource "openstack_compute_instance_v2" "vm" {
  name        = var.vm_name
  image_name  = var.image_name
  flavor_name = var.flavor_name
  key_pair    = openstack_compute_keypair_v2.lab_keypair.name

  network {
    port = openstack_networking_port_v2.vm_port.id
  }

  depends_on = [openstack_networking_router_interface_v2.router_int]
}

# ── Floating IP ───────────────────────────────────────────────────────────────

resource "openstack_networking_floatingip_v2" "fip" {
  pool = var.external_network_name
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  port_id     = openstack_networking_port_v2.vm_port.id
}
