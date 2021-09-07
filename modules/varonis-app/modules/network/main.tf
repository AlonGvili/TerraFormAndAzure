resource "random_integer" "vnicid" {
  min = 123456
  max = 654321
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-${var.location}-vnet"
  address_space       = var.address_space
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-${var.location}-subnet"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_interface" "vnic" {
  count               = var.virtual_machine_count
  name                = "${var.prefix}-${var.location}-vnic-${random_integer.vnicid.result}-${count.index}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "dynamic"
    primary                       = true
  }

  tags = var.tags
}

