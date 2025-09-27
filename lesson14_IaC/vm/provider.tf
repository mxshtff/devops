terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoints = {
      s3       = "https://storage.yandexcloud.net"
    }
    bucket            = "2025-07-levelup-devops"
    region            = "ru-central1"
    key               = "lesson14/terraform.tfstate"

    use_lockfile = true

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.
  }
}

provider "yandex" {
  service_account_key_file = "../key.json"
  folder_id = "b1g4irnljhuftrnnkos6"
  zone = "ru-central1-a"
}