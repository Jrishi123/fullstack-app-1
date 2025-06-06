# Variables
variable "vpc_id" {
  description = "The VPC ID to deploy resources into"
  type        = string
}

variable "subnet_ids" {
  description = "Public subnet IDs for ECS service"
  type        = list(string)
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Cluster
resource "aws_ecs_cluster" "app_cluster" {
  name = "fullstack-app-cluster"
}

# Security Group for ECS
resource "aws_security_group" "ecs_alternate_sg" {
  name        = "ecs_alternate_sg"
  description = "Security group for ECS service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_alternate_sg"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app_task" {
  family                   = "fullstack-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "app-container"
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      protocol      = "tcp"
    }]
  }])
}

# ECS Service
resource "aws_ecs_service" "app_service" {
  name            = "fullstack-app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_alternate_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution_policy,
    aws_security_group.ecs_alternate_sg
  ]
}
