resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = "20"
  image_id = "fd8kc2n656prni2cimp5"
}


data "yandex_vpc_subnet" "selected" {
#   subnet_id = "e9bi1vo3i3vg4ris2c0p"
  name  = "default-ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = var.hostname

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.selected.id
    # subnet_id = "e9bi1vo3i3vg4ris2c0p"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("./keys/lesson_iac_yc_rsa.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./keys/lesson_iac_yc_rsa")
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "file" {
    source      = "scripts/init.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }

}
