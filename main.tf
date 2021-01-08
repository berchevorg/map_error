variable "subnetworks" {
  type    = map
  default = {}
}

variable "region" {}

provider "aws" {
  region  = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "110.0.0.0/16"
}

resource "null_resource" "cidrs" {
  for_each = var.subnetworks
  triggers = {
    parent     = lookup(each.value, "parent", null)
    netview    = lookup(each.value, "netview", null)
    comment    = format("%s-%s", "lh-dtep", each.key)
    project_id = "lh-dtep"
    netmask    = each.value["netmask"]
    location   = lookup(each.value, "location", null)
    region     = lookup(each.value, "location", null) == null ? null : each.value["region"]
  }
}
