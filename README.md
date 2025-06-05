# Fullstack App on AWS ECS with Terraform

This project is a fullstack Todo application developed using React (frontend) and Node.js (backend), containerized using Docker, and deployed on AWS using ECS Fargate. Infrastructure is fully provisioned using Terraform, showcasing modern DevOps practices and cloud-native deployment.

## Tech Stack

- Frontend: React.js
- Backend: Node.js, Express
- Containerization: Docker
- Cloud Provider: AWS
- Container Orchestration: ECS Fargate
- Infrastructure as Code: Terraform
- Load Balancer: Application Load Balancer (ALB)
- Optional: RDS / DynamoDB (if used)

## Architecture

![Architecture Diagram](./architecture.png)


## Deploying Infrastructure with Terraform

1. Navigate to the Terraform directory:
   ```bash
   cd terraform


## CI/CD (Optional)

- GitHub Actions used to automate Terraform plan/apply
- Automatically builds and pushes Docker images to ECR on push to `main` branch

# Fullstack App on AWS ECS with Terraform

This project is a fullstack web application consisting of a React frontend and a Node.js backend, containerized using Docker and deployed on Amazon ECS using Fargate. The entire infrastructure is provisioned using Terraform, demonstrating cloud-native architecture and DevOps best practices. This app is designed to be scalable, maintainable, and fully automated from source to deployment.
