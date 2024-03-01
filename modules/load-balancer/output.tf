output "public_dns" {
  value = aws_lb.path_load_balancer.dns_name

}
