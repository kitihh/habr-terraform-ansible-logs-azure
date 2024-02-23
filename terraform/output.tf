output "grafana_ip_address" {
    value = yandex_compute_instance.grafana.network_interface.0.nat_ip_address
}

output "node1_ip_address" {
    value = yandex_compute_instance.node1.network_interface.0.nat_ip_address
}

output "node2_ip_address" {
    value = yandex_compute_instance.node2.network_interface.0.nat_ip_address
}

output "node3_ip_address" {
    value = yandex_compute_instance.node3.network_interface.0.nat_ip_address
}
