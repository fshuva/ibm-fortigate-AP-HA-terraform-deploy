# Your SSH key
variable "SSH_PUBLIC_KEY" {
  default     = ""
  description = "The name(ID) of your ssh public key to be used."
}
// Magic Value for Calalog Validation that initlizes terraform with a specific version.
// Only needed in IBM catalog.
variable "TF_VERSION" {
  default     = "0.13"
  description = "Terraform version to be used in validation"
}

// IBM Regions
variable "REGION" {
  type        = string
  default     = "us-south"
  description = "Deployment Region"
}
// IBM availability zones
variable "ZONE1" {
  type        = string
  default     = "us-south-1"
  description = "Deployment Zone Primary(Active) FortiGate."
}
variable "ZONE2" {
  type        = string
  default     = "us-south-2"
  description = "Secondary Zone for Secondary(Passive) FortiGate."
}
variable "VPC" {
  type        = string
  default     = ""
  description = "Name of the VPC you want to deploy a FortiGate into."
}
variable "ZONE1_SUBNET_1" {
  type        = string
  default     = ""
  description = "The Primary, Public Subnet Used for port1 on the ACTIVE FortiGate"
}
variable "ZONE1_SUBNET_2" {
  type        = string
  default     = ""
  description = "The Secondary, Private Subnet Used for port2 on the ACTIVE FortiGate"
}
variable "ZONE2_SUBNET_1" {
  type        = string
  default     = ""
  description = "The Primary, Public Subnet Used for port1 on the PASSIVE FortiGate"
}
variable "ZONE2_SUBNET_2" {
  type        = string
  default     = ""
  description = "The Secondary, Private Subnet Used for port2 on the PASSIVE FortiGate"
}
variable "NETMASK" {
  type        = string
  default     = "255.255.255.0"
  description = "Subnet Mask for Static IP and Nic of each FortiGate."
}

variable "FGT1_STATIC_IP_PORT1" {
  type        = string
  default     = ""
  description = "REQUIRED - STATIC IP Assignment for the Primary (ACTIVE) FortiGate Port1. This is used for HA SYNC."
}
variable "FGT1_STATIC_IP_PORT2" {
  type        = string
  default     = ""
  description = "OPTIONAL - STATIC IP Assignment for the Primary (ACTIVE) FortiGate Port2. If not assigned DHCP will be used."
}
variable "FGT2_STATIC_IP_PORT1" {
  type        = string
  default     = ""
  description = "REQUIRED -STATIC IP Assignment for the Secondary (PASSIVE) FortiGate Port1. This is used for HA SYNC"
}
variable "FGT2_STATIC_IP_PORT2" {
  type        = string
  default     = ""
  description = "OPTIONAL - STATIC IP Assignment for the Secondary (PASSIVE) FortiGate Port2. If not assigned DHCP will be used."
}

variable "SECURITY_GROUP" {
  type        = string
  default     = ""
  description = "The Security Group to attach to the FortiGate Instance Network Interfaces."
}


// Name will be in the format of cluster_name-RESOURCE-randomSuffix to be easily identifiable.
// Name must be lowercase
variable "CLUSTER_NAME" {
  type        = string
  default     = "fortigate-terraform"
  description = "Name will be in the format of cluster-name-resource-randomSuffix to be easily identifiable. Must be LOWER case"
}
// Random Suffix to avoid name collisions and identify cluster.
resource "random_string" "random_suffix" {
  length           = 4
  special          = true
  override_special = ""
  min_lower        = 4
}


// FortiOS Custom Image ID
// https://docs.fortinet.com/vm/ibm/fortigate/6.4/ibm-cloud-cookbook/6.4.2/992669/deploying-fortigate-vm-on-ibm-cloud
// Deploys 6.4.3 Image
// 6.4.4 available link: cos://us-geo/fortinet/fortigate_byol_644_b1803_GA.qcow2
// cos://us-geo/fortinet/fortigate_byol_700_b0066_GA.qcow2 7.0
variable "image" {
  default = "cos://us-geo/fortinet/fortigate_byol_644_b1803_GA.qcow2"
}
variable "IBMCLOUD_API_KEY" {
  default     = ""
  description = "Your IBM USER API key. Refer to the README for Links to documentation for IBM API keys. This Value is required for the SDN Connector For HA SYNC"

}
// Default Instance type
// See: https://cloud.ibm.com/docs/vpc?topic=vpc-profiles
variable "PROFILE" {
  default     = "cx2-2x4"
  description = "VM size and family. See README for links to documentation on IBM instance types."
}