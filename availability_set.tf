resource "azurerm_availability_set" "fweb_availability_set" {
  name                = "fweb_availability_set"
  location            = azurerm_resource_group.myterraformgroup.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name
}
