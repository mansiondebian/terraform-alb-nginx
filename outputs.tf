# === Outputs del proyecto ===

output "alb_dns" {
  description = "DNS público del Application Load Balancer"
  value       = aws_lb.main.dns_name
}
