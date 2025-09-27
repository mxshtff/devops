# yandex_compute_instance.vm-1:
resource "yandex_compute_instance" "vm-1" {
    folder_id                 = "b1g4irnljhuftrnnkos6"
    # hardware_generation       = [
    #     {
    #         generation2_features = []
    #         legacy_features      = [
    #             {
    #                 pci_topology = "PCI_TOPOLOGY_V1"
    #             },
    #         ]
    #     },
    # ]
    hostname                  = "compute-vm-2-2-20-hdd-1758041639454"
    labels                    = {}
    metadata                  = {
        "ssh-keys"  = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnhuaFtPxHkHUMhJTSe3gFeospx977i/3wmDulp2wIZCUtM+twQVZaARQ/tJCYSeuASqcq+2cTFH4d7CydlvL9GIdmqtrQW0bluD0cgmXkpPK0hbi2IZ2FUNtCTB1LqnJ/jahKLUUSXljLX8qVZx8dI++fwTC01Hy/KrvBYc8Ez/QessdsImSAYbKMEw5ndafDrC4ut/HkYYvBFaYjQeLjoA/PCjGiL0HyXxU7Xj84et/5KFICSNf7PEfpoGmqyrghMcbSXL+3k3VrDHUtWGqnncA3fcNPHGvlhPb+Hq8isaaX9Cdp/NP8sfKHgn4u3mfqX9j+bhYno3tRKefQvACg80/M1woyXQ9V/7wXwPmqQQGG5bhlgf73Sg/xPRnI7BEC/+nw5Rl2mXVySQukFiJtffH7OlYUnYqg7x4AHnnLWcQ9+Glv0JwOsarUNiGHpe8QKdYTzXEaGrsCWEQ9a4vcLLSQnWgHJdgkNRSHcngixI1OTCDvn1PlvBy43h18IO0= vagrant@iac"
        "user-data" = <<-EOT
            #cloud-config
            datasource:
             Ec2:
              strict_id: false
            ssh_pwauth: no
            users:
            - name: ubuntu
              sudo: ALL=(ALL) NOPASSWD:ALL
              shell: /bin/bash
              ssh_authorized_keys:
              - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnhuaFtPxHkHUMhJTSe3gFeospx977i/3wmDulp2wIZCUtM+twQVZaARQ/tJCYSeuASqcq+2cTFH4d7CydlvL9GIdmqtrQW0bluD0cgmXkpPK0hbi2IZ2FUNtCTB1LqnJ/jahKLUUSXljLX8qVZx8dI++fwTC01Hy/KrvBYc8Ez/QessdsImSAYbKMEw5ndafDrC4ut/HkYYvBFaYjQeLjoA/PCjGiL0HyXxU7Xj84et/5KFICSNf7PEfpoGmqyrghMcbSXL+3k3VrDHUtWGqnncA3fcNPHGvlhPb+Hq8isaaX9Cdp/NP8sfKHgn4u3mfqX9j+bhYno3tRKefQvACg80/M1woyXQ9V/7wXwPmqQQGG5bhlgf73Sg/xPRnI7BEC/+nw5Rl2mXVySQukFiJtffH7OlYUnYqg7x4AHnnLWcQ9+Glv0JwOsarUNiGHpe8QKdYTzXEaGrsCWEQ9a4vcLLSQnWgHJdgkNRSHcngixI1OTCDvn1PlvBy43h18IO0= vagrant@iac
        EOT
    }
    name                      = "compute-vm-2-2-20-hdd-1758041639454"
    network_acceleration_type = "standard"
    platform_id               = "standard-v3"
    zone                      = "ru-central1-d"

    boot_disk {
        auto_delete = true
        device_name = "fv4kqg9di4kenb5fbkpl"
        disk_id     = "fv4kqg9di4kenb5fbkpl"
        mode        = "READ_WRITE"

        initialize_params {
            block_size  = 4096
            image_id    = "fd888dplf7gt1nguheht"
            name        = "disk-ubuntu-24-04-lts-1758041639651"
            size        = 20
            type        = "network-hdd"
        }
    }

    # metadata_options {
    #     aws_v1_http_endpoint = 1
    #     aws_v1_http_token    = 2
    #     gce_http_endpoint    = 1
    #     gce_http_token       = 1
    # }

    network_interface {
        index              = 0
        ip_address         = "10.130.0.22"
        ipv4               = true
        ipv6               = false
        # mac_address        = "d0:0d:1b:0f:b0:6a"
        nat                = true
        nat_ip_address     = "158.160.142.38"
        # nat_ip_version     = "IPV4"
        security_group_ids = []
        subnet_id          = "fl8vdo5slflqau44f6u2"
    }

    # placement_policy {
    #     host_affinity_rules       = []
    #     placement_group_id        = [90mnull[0m[0m
    #     placement_group_partition = 0
    # }

    resources {
        core_fraction = 50
        cores         = 2
        gpus          = 0
        memory        = 2
    }

    scheduling_policy {
        preemptible = false
    }
}
