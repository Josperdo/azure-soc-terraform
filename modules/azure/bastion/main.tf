# ─── Public IP for Azure Bastion ─────────────────────────────────────────────
# Azure Bastion requires a Standard SKU static public IP.

resource "azurerm_public_ip" "bastion" {
  name                = "${var.prefix}-bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# ─── Azure Bastion Host ───────────────────────────────────────────────────────
# Provides secure, browser-based SSH/RDP access to VMs without exposing
# any public IP on the VMs themselves.

resource "azurerm_bastion_host" "this" {
  name                = "${var.prefix}-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.bastion_sku
  tags                = var.tags

  # Native client (az network bastion ssh/rdp) and IP-based connect require
  # Standard/Premium SKU *and* these flags explicitly enabled — the SKU alone
  # doesn't turn them on. Basic SKU doesn't support either, so both stay false.
  tunneling_enabled  = var.bastion_sku != "Basic"
  ip_connect_enabled = var.bastion_sku != "Basic"

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
