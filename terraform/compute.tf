resource "yandex_compute_disk" "disks-for-logs" {
  count = 4

  block_size = 4096
  image_id   = "fd8b24tqvq7t2f8a1o1s"
  size       = 10
  type       = "network-ssd"
}

resource "yandex_compute_instance" "grafana" {
  hostname                  = "grafana"
  name                      = "grafana"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  service_account_id        = yandex_iam_service_account.compute-editor.id

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    install-unified-agent = "0"
    ssh-keys              = "admin:${file("~/.ssh/habr-logs/grafana.pub")}"
    user-data             = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: admin
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ${file("~/.ssh/habr-logs/grafana.pub")}
      EOT
  }

  boot_disk {
    auto_delete = true
    device_name = yandex_compute_disk.disks-for-logs[0].name
    disk_id     = yandex_compute_disk.disks-for-logs[0].id
    mode        = "READ_WRITE"
  }

  network_interface {
    subnet_id =    yandex_vpc_subnet.default-ruc1-a.id
    ipv4           = true
    nat            = true
  }

  resources {
    core_fraction = 5
    cores         = 2
    gpus          = 0
    memory        = 2
  }
}

resource "yandex_compute_instance" "node1" {
  hostname                  = "node1"
  name                      = "node1"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  service_account_id        = yandex_iam_service_account.compute-editor.id

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    install-unified-agent = "0"
    ssh-keys              = "admin:${file("~/.ssh/habr-logs/node1.pub")}"
    user-data             = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: admin
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ${file("~/.ssh/habr-logs/node1.pub")}
      EOT
  }

  boot_disk {
    auto_delete = true
    device_name = yandex_compute_disk.disks-for-logs[1].name
    disk_id     = yandex_compute_disk.disks-for-logs[1].id
    mode        = "READ_WRITE"
  }

  network_interface {
    subnet_id =    yandex_vpc_subnet.default-ruc1-a.id
    ipv4           = true
    nat            = true
  }

  resources {
    core_fraction = 5
    cores         = 2
    gpus          = 0
    memory        = 2
  }
}

resource "yandex_compute_instance" "node2" {
  hostname                  = "node2"
  name                      = "node2"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  service_account_id        = yandex_iam_service_account.compute-editor.id

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    install-unified-agent = "0"
    ssh-keys              = "admin:${file("~/.ssh/habr-logs/node2.pub")}"
    user-data             = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: admin
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ${file("~/.ssh/habr-logs/node2.pub")}
      EOT
  }

  boot_disk {
    auto_delete = true
    device_name = yandex_compute_disk.disks-for-logs[2].name
    disk_id     = yandex_compute_disk.disks-for-logs[2].id
    mode        = "READ_WRITE"
  }

  network_interface {
    subnet_id =    yandex_vpc_subnet.default-ruc1-a.id
    ipv4           = true
    nat            = true
  }

  resources {
    core_fraction = 5
    cores         = 2
    gpus          = 0
    memory        = 2
  }
}

resource "yandex_compute_instance" "node3" {
  hostname                  = "node3"
  name                      = "node3"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  service_account_id        = yandex_iam_service_account.compute-editor.id

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    install-unified-agent = "0"
    ssh-keys              = "admin:${file("~/.ssh/habr-logs/node3.pub")}"
    user-data             = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: admin
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ${file("~/.ssh/habr-logs/node3.pub")}
      EOT
  }

  boot_disk {
    auto_delete = true
    device_name = yandex_compute_disk.disks-for-logs[3].name
    disk_id     = yandex_compute_disk.disks-for-logs[3].id
    mode        = "READ_WRITE"
  }

  network_interface {
    subnet_id =    yandex_vpc_subnet.default-ruc1-a.id
    ipv4           = true
    nat            = true
  }

  resources {
    core_fraction = 5
    cores         = 2
    gpus          = 0
    memory        = 2
  }
}
