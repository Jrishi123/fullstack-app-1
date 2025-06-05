output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets" {
  value = aws_subnet.public[*].id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "alb_dns" {
  value = aws_lb.app.dns_name
}
