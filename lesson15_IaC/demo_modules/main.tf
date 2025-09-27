module "network" {
  source = "../modules/network"
  vpc_network_name = "default"
}

module "instance" {
  source = "../modules/instance"
  zone = var.zone
  subnet_id = module.network.subnets[var.zone].subnet_id
  hostname = var.hostname
}