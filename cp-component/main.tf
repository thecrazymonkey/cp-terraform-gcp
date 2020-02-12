locals {
  component   = var.component
  server_sets = var.server_sets
  zone_id     = var.dns_zone
  key_name    = var.key_name
  key_file    = var.key_file
  image_name  = var.image_name
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "this" {
  count        = local.server_sets[local.component]["count"]
  name         = "${local.server_sets[local.component]["dns_name"]}${count.index+1}-${var.user_name}"
  hostname     = "${local.server_sets[local.component]["dns_name"]}${count.index+1}.${var.name_prefix}.${var.domain_name}"

  machine_type = local.server_sets[local.component]["size"]
  tags         = [var.user_name]

  boot_disk {
      initialize_params {
        image = var.image_name
        size = local.server_sets[local.component]["volume_size"]
      }
  }

  // Make sure flask is installed on all new instances for later steps
  metadata_startup_script = "sudo yum update"

  network_interface {
     network = "default"

     access_config {
     // Include this section to give the VM an external ip address
     }
  }
  metadata = {
     ssh-keys = "${var.key_name}:${file("${var.key_file}")}"
  }
}
// A variable for extracting the external ip of the instance
output "ip" {
  value = google_compute_instance.this.*.network_interface.0.network_ip
}
// A variable for extracting the hostname of the instance
output "hostname" {
 value = google_compute_instance.this.*.hostname
}

resource "aws_route53_record" "this" {
  zone_id = local.zone_id
  count   = local.server_sets[local.component]["count"]
  name    = "${local.server_sets[local.component]["dns_name"]}${count.index+1}.${var.name_prefix}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [google_compute_instance.this[count.index].network_interface.0.access_config.0.nat_ip]
}
