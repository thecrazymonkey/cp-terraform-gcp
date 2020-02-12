# simple terraform to creat CP cluster within AWS, software provisioning to be done via cp-ansible

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

provider "google" {
  region  = var.region
  project = "solutionsarchitect-01"
  credentials = file("/Users/ikunz/.gcloud/account.json")
  zone         = "us-east4-a"
}

# use aws for DNS
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  profile = "confluentsa"
}

resource "google_compute_firewall" "default" {
 name    = "${var.user_name}-firewall"
 network = "default"

 allow {
   protocol = "icmp"
 }

 allow {
   protocol = "tcp"
   ports    = ["2181", "9091-9093", "8081-8083", "8088", "9021", "9999", "8080", "9090"]
 }

 source_ranges = [format("%s/32",chomp(data.http.myip.body))]
 source_tags = [var.user_name]
 target_tags = [var.user_name]
}

#resource "gcp_instance" "ivan_jump" {
#  ami           = "ami-02eac2c0129f6376b"
#  instance_type = "t2.micro"
#}

module "cp_gcp_zk" {
  source      = "./cp-component"
  component   = "zk"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}

module "cp_gcp_bk" {
  source      = "./cp-component"
  component   = "broker"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}

module "cp_gcp_co" {
  source      = "./cp-component"
  component   = "connect"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}
module "cp_gcp_rp" {
  source      = "./cp-component"
  component   = "restproxy"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}
module "cp_gcp_sr" {
  source      = "./cp-component"
  component   = "schemaregistry"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}

module "cp_gcp_ks" {
  source      = "./cp-component"
  component   = "ksql"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}

module "cp_gcp_cc" {
  source      = "./cp-component"
  component   = "controlcenter"
  server_sets = var.server_sets
  image_name  = var.image_name
  key_name    = var.key_name
  key_file    = var.key_file
  domain_name = var.domain_name
  name_prefix = var.name_prefix
  dns_zone    = var.dns_zone
  user_name   = var.user_name
}
