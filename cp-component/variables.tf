variable "component" {
  description = "Name to be used to select from the set"
}

variable "image_name" {
  description = "GCP image"
  type        = string
}

variable "server_sets" {
  description = "Copy of server sets"
  type        = map(map(string))
}

variable "key_name" {
  description = "Key name"
  type        = string
  default     = ""
}

variable "key_file" {
  description = "Key file"
  type        = string
  default     = ""
}

variable "name_prefix" {
  type        = string
}

variable "user_name" {
  type        = string
}

variable "domain_name" {
  type        = string
}

variable "dns_zone" {
  type        = string
}
