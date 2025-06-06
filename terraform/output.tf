output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ecs_cluster_id" {
  value       = aws_ecs_cluster.app_cluster.id
  description = "ID of the ECS Cluster"
}
output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.app_alb.dns_name
}

# output "rds_endpoint" {
#   value = aws_db_instance.app_db.endpoint
# }

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

