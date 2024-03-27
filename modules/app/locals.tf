locals {
  tcp_protocol            = "tcp"
  interface_endpoint_port = 443
  all_ips                 = "0.0.0.0/0"
  any_protocol            = "-1"

  resource_name = "${var.environment}-${var.project_name}"
}
