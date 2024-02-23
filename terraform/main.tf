terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  zone_id   = "ru-central1-a"
  folder_id = "b1g61a9am7f9hp4hcqjp"
}

provider "yandex" {
  zone = local.zone_id
}

