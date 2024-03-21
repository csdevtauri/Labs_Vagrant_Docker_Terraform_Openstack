# main.tf
# Define required providers
terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.44.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
}

resource "openstack_compute_keypair_v2" "devomax_ssh_infomaniak" {
  name       = "devomax_ssh_infomaniak"
  public_key = var.public_key
}

# Create a web server instance
resource "openstack_compute_instance_v2" "web-server" {
  name            = "web-server"
  image_id        = var.image_id
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.devomax_ssh_infomaniak.name
  security_groups = [openstack_compute_secgroup_v2.web_server.name]

  network {
    name = var.network_name
  }
}

# Create a web security group
resource "openstack_compute_secgroup_v2" "web_server" {
  name        = "web_server"
  description = "Security Group Description"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

