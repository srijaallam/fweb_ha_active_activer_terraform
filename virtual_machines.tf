resource "azurerm_virtual_machine" "fweb_a_vm"{  
      resource_group_name = azurerm_resource_group.myterraformgroup.name
      location            = azurerm_resource_group.myterraformgroup.location
      vm_size             = var.size
      name                = "vm-fweb-a"
      availability_set_id = azurerm_availability_set.fweb_availability_set.id

      storage_image_reference {
            publisher = var.publisher
            offer     = var.fweboffer
            sku       = var.fwebsku
            version   = var.fwebversion
        }

        plan {
        name       = var.fwebsku
        product    = var.fweboffer
        publisher  = var.publisher
        }

      delete_os_disk_on_termination    = true
      delete_data_disks_on_termination = true

      network_interface_ids        = [azurerm_network_interface.activeport1.id,azurerm_network_interface.activeport2.id]
      primary_network_interface_id = azurerm_network_interface.activeport1.id

      os_profile {
        computer_name  = "hostname"
        admin_username = "azureuser"
        admin_password = "Password1234!"
        }

      os_profile_linux_config {
        disable_password_authentication = false
        }

      storage_os_disk {
        name              = "disk_os_fweb_a"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
        }

    }
    data "template_file" "fgt_a_custom_data" {
        template = file("${path.module}/active.tpl")

         vars = {
            passiveport2 = var.passiveport2
            activeport2  = var.activeport2
         }
    }

    resource "azurerm_virtual_machine" "fweb_b_vm"{  
      
      resource_group_name = azurerm_resource_group.myterraformgroup.name
      location            = azurerm_resource_group.myterraformgroup.location
      vm_size             = var.size
      name                = "vm-fweb-b"
      availability_set_id = azurerm_availability_set.fweb_availability_set.id

      storage_image_reference {
            publisher = var.publisher
            offer     = var.fweboffer
            sku       = var.fwebsku
            version   = var.fwebversion
        }

       plan {
            name       = var.fwebsku
            product    = var.fweboffer
            publisher  = var.publisher
        }
      delete_os_disk_on_termination    = true
      delete_data_disks_on_termination = true

      network_interface_ids        = [azurerm_network_interface.passiveport1.id,azurerm_network_interface.passiveport2.id]
      primary_network_interface_id = azurerm_network_interface.passiveport1.id

      os_profile {
        computer_name  = "hostname"
        admin_username = "azureuser"
        admin_password = "Password1234!"
        }

      os_profile_linux_config {
        disable_password_authentication = false
        }

      storage_os_disk {
        name              = "disk_os_fweb_b"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
        }
    }

data "template_file" "fgt_b_custom_data" {
            template = file("${path.module}/passive.tpl")


        vars = {
            passiveport2 = var.passiveport2
            activeport2  = var.activeport2
        } 
}

