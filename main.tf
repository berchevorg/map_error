variable "subnetworks" {
  type    = map
  default = {}
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
