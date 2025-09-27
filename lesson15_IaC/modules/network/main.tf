data "yandex_vpc_network" "this" {
  name  = var.vpc_network_name
}


data "yandex_vpc_subnet" "this" {
  for_each = toset(var.vpc_network_zones)
  name = "${data.yandex_vpc_network.this.name}-${each.key}"
}

