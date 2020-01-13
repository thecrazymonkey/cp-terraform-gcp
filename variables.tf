# Configure the GCloud Provider
variable "region" {
  default = "us-east4"
}
variable "dns_zone" {
  # nerdynick
  default = "Z7RSBY5AAK0K7"
}
variable "my_dns" {
  default = "crazymonkey.duckdns.org"
}

variable "name_prefix" {
  default = "ivan"
}
variable "key_name" {
  default = "ikunz"
}
variable "key_file" {
  default = "/Users/ikunz/.ssh/ivan-gcp.pub"
}

variable "domain_name" {
  default = "crazymonkey-net"
}

variable "image_name" {
  default = "centos-cloud/centos-7"
}

variable "server_sets" {
  description = "Describes specific settings for individual CP servers (count, type, .....)"
  default = {
    "zk" = {
        count = 3,
        size = "n1-standard-1",
        volume_size = 10,
        dns_name = "zk"
    }
    "broker" = {
        count = 3,
        size = "n1-standard-2",
        volume_size = 50,
        dns_name = "kafka"
    }
    "connect" = {
        count = 0,
        size = "n1-standard-2",
        volume_size = 40,
        dns_name = "connect"
    }
    "schemaregistry" = {
        count = 0,
        size = "n1-standard-2",
        volume_size = 30,
        dns_name = "schemaregistry"
    }
    "restproxy" = {
        count = 0,
        size = "n1-standard-2",
        volume_size = 10,
        dns_name = "restproxy"
    }
    "controlcenter" = {
        count = 0,
        size = "n1-standard-2",
        volume_size = 30,
        dns_name = "kafka"
    }
    "ksql" = {
        count = 0,
        size = "n1-standard-2",
        volume_size = 30,
        dns_name = "ksql"
    }
  }
}