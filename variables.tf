variable "create_route_table" {
  type    = bool
  default = true
}

variable "route_definitions" {
  description = "Map of route definitions"
  type = map(object({
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "associate_to_subnet" {
  type    = bool
  default = true
}

variable "subnet_id" {
  type    = string
  default = "" # Pass the subnet ID here
}
