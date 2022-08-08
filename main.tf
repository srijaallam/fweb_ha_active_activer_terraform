// Resource Group

resource "azurerm_resource_group" "myterraformgroup" {
  name     = "sallam-terraformRSG"
  location = var.location
}