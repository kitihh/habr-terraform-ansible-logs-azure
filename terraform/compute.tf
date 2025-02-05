# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}-monitoring"
  location = var.location
}

# VMs and their components
locals {
  vm_configs = {
    grafana = {
      size     = "Standard_B1s" # Cost-effective size
      priority = "Spot"
    }
    node1 = {
      size     = "Standard_B1s"
      priority = "Spot"
    }
    node2 = {
      size     = "Standard_B1s"
      priority = "Spot"
    }
    node3 = {
      size     = "Standard_B1s"
      priority = "Spot"
    }
  }
}

# Managed Disks
resource "azurerm_managed_disk" "disk" {
  for_each             = local.vm_configs
  name                 = "disk-${var.environment}-${each.key}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 2
}

# Virtual Machines
resource "azurerm_virtual_machine" "vm" {
  for_each              = local.vm_configs
  name                  = "vm-${var.environment}-${each.key}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  vm_size               = each.value.size
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  # VM Priority (Spot)
  # priority        = each.value.priority
  # eviction_policy = "Deallocate"
  # max_bid_price   = -1

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${var.environment}-${each.key}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm-${var.environment}-${each.key}"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }
}

# Attach managed disks to VMs
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  for_each           = local.vm_configs
  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = azurerm_virtual_machine.vm[each.key].id
  lun                = 10
  caching            = "ReadWrite"
}
