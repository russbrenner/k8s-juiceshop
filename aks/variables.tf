//********************** Basic Configuration Variables **************************//

variable resource_group_name {
    type = string
}

variable location {
    type = string
}

//********************** Aks variables *******************//

variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    type = string
}

variable cluster_name {
    type = string
}

variable vmsize {
    type = string
}

variable log_analytics_workspace_name {
    type = string
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    type = string
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    type = string
}