output "load_balancer_dns" {
  value = aws_lb.eb_lb.dns_name
}