resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_route_table" "example" {
  name                = "acceptanceTestRouteTable1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_route" "example" {
  name                = "acceptanceTestRoute1"
  resource_group_name = azurerm_resource_group.example.name
  route_table_name    = azurerm_route_table.example.name
  address_prefix      = "10.1.0.0/16"
  next_hop_type       = "VnetLocal"
}