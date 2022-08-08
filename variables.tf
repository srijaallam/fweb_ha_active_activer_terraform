/* Azure configuration
variable subscription_id {}
variable client_id {}
variable client_secret {}
variable tenant_id {}
*/

//  For HA, choose instance size that support 4 nics at least
//  Check : https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes
variable "size" {
  type    = string
  default = "Standard_F2s"
}

variable "location" {
  type    = string
  default = "westus2"
}

// To use custom image 
// by default is false
variable "custom" {
  default = false
}

//  Custom image blob uri
variable "customuri" {
  type    = string
  default = "<custom image blob uri>"
}

variable "custom_image_name" {
  type    = string
  default = "<custom image name>"
}

variable "custom_image_resource_group_name" {
  type    = string
  default = "<custom image resource group>"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiWeb-VM Instances, either byol or payg.
variable "license_type" {
  default = "byol"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fweboffer" {
  type    = string
  default = "fortinet_fortiweb-vm_v5"
}

// BYOL sku: fortinet_fw-vm
// PAYG sku: fortinet_fw-vm_payg_v2
variable "fwebsku" {
  type = string
  default = "fortinet_fw-vm"
   
}

// FOS version
variable "fwebversion" {
  type    = string
  default = "latest"
}

variable "adminusername" {
  type    = string
  default = "azureadmin"
}


variable "vnetcidr" {
  default = "172.1.0.0/21"
}

variable "publiccidr" {
  default = "172.1.0.0/24"
}

variable "privatecidr" {
  default = "172.1.1.0/24"
}

variable "activeport1" {
  default = "172.1.0.10"
}

variable "activeport1mask" {
  default = "255.255.255.0"
}

variable "activeport2" {
  default = "172.1.1.10"
}

variable "activeport2mask" {
  default = "255.255.255.0"
}

variable "passiveport1" {
  default = "172.1.0.11"
}

variable "passiveport1mask" {
  default = "255.255.255.0"
}

variable "passiveport2" {
  default = "172.1.1.11"
}

variable "passiveport2mask" {
  default = "255.255.255.0"
}

// license file for the active fweb
variable "licenseFile" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license1.lic"
}

// license file for the passive fweb
variable "licenseFile2" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "license2.lic"
}