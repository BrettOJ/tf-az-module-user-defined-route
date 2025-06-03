resource "azurerm_route_table" "this" {
  count               = var.create_route_table ? 1 : 0
  name                = "example-route-table"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false
  tags = {
    environment = "dev"
  }
}

resource "azurerm_route" "this" {
  for_each = var.create_route_table ? var.route_definitions : {}

  name                   = each.key
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.this[0].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = lookup(each.value, "next_hop_in_ip_address", null)
}

resource "azurerm_subnet_route_table_association" "this" {
  count          = var.create_route_table && var.associate_to_subnet ? 1 : 0
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.this[0].id
}
