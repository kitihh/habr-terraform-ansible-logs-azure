output "grafana_public_ip" {
  value = azurerm_public_ip.pip["grafana"].ip_address
}

output "node_public_ips" {
  value = {
    for k, v in azurerm_public_ip.pip : k => v.ip_address
    if k != "grafana"
  }
}
