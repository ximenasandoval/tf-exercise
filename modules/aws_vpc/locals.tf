locals {
  subnet_cidrs               = cidrsubnets(var.cidr_block, tonumber(split("/", var.cidr_block)[1]) / 2, tonumber(split("/", var.cidr_block)[1]) / 2)
  subnets_availability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, 2)
}
