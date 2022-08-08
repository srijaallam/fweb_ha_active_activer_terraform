resource "azurerm_storage_account" "fweb_storage" {
  name                     = "fwebstorageaccountname"
  resource_group_name      = azurerm_resource_group.myterraformgroup.name
  location                 = azurerm_resource_group.myterraformgroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}