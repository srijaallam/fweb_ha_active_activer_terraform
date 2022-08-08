resource "azurerm_lb" "external_loadbalancer" {
  name                = "External_LoadBalancer"
  location            = azurerm_resource_group.myterraformgroup.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ClusterPublicIP.id
  }

  depends_on = ["azurerm_availability_set.fweb_availability_set"]
    
}

resource "azurerm_lb_rule" "http" {
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "PublicLBRule-FE1-http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.health_probe_http.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
}


resource "azurerm_lb_rule" "https" {
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "PublicLBRule-FE1-https"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.health_probe_https.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id     = azurerm_lb.external_loadbalancer.id
  name                = "FWEB-ILB-ExternalSubnet-BackEnd"
}

resource "azurerm_lb_probe" "health_probe_http" {
  loadbalancer_id = azurerm_lb.external_loadbalancer.id
  name            = "heatlhProbeHttp"
  port            = 80
}

resource "azurerm_lb_probe" "health_probe_https" {
  loadbalancer_id = azurerm_lb.external_loadbalancer.id
  name            = "heatlhProbeHttps"
  port            = 443
}

resource "azurerm_lb_nat_rule" "fweb_a_ssh" {
  resource_group_name            = azurerm_resource_group.myterraformgroup.name
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "fweb_a_ssh_access"
  protocol                       = "Tcp"
  frontend_port                  = 50030
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  //backend_address_pool_ids       = azurerm_lb_backend_address_pool.lb_backend_pool.id
  
}

resource "azurerm_lb_nat_rule" "fweb_b_ssh" {
  resource_group_name            = azurerm_resource_group.myterraformgroup.name
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "fweb_b_ssh_access"
  protocol                       = "Tcp"
  frontend_port                  = 50031
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  //backend_address_pool_ids       = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_lb_nat_rule" "fweb_a_mgmt" {
  resource_group_name            = azurerm_resource_group.myterraformgroup.name
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "fweb_a_mgmt_Access"
  protocol                       = "Tcp"
  frontend_port                  = 40030
  backend_port                   = 8443
  frontend_ip_configuration_name = "PublicIPAddress"
  //backend_address_pool_ids       = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_lb_nat_rule" "fweb_b_mgmt" {
  resource_group_name            = azurerm_resource_group.myterraformgroup.name
  loadbalancer_id                = azurerm_lb.external_loadbalancer.id
  name                           = "fweb_b_mgmt_access"
  protocol                       = "Tcp"
  frontend_port                  = 40031
  backend_port                   = 8443
  frontend_ip_configuration_name = "PublicIPAddress"
  //backend_address_pool_ids       = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

