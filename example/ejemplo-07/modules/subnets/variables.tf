variable "vpc_id" {
  type        = string
  description = "ID de la VPC"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "Lista de CIDRs para las subnets"
}

variable "azs" {
  type        = list(string)
  description = "Zonas de disponibilidad"
}

variable "name" {
  type        = string
  description = "Prefijo de nombre para las subnets"
}

variable "public_route_table_id" {
  type = string
  description = "Route table ID for the public subnets"
}
