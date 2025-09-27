variable "vpc_network_zones" {
  type = list(string)
  default = [ "ru-central1-a", "ru-central1-b", "ru-central1-d" ]
}

variable "vpc_network_name" {
    type = string
    default = "default"
}