resource "yandex_vpc_network" "default" {
  description = "Auto-created network"
  name        = "default"
}

resource "yandex_vpc_subnet" "default-ruc1-a" {
  name           = "default-ru-central1-a"
  zone           = local.zone_id
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = [var.default_ru_central1_a_subnet_cidr_block]
}
