# Terraform Deployment Guide

## Prerequisites

- Terraform >= 1.0 installed
- AWS CLI configured with necessary permissions
- AWS Account with proper IAM roles
- Clone this repo

## How to deploy

```bash
cd terraform
terraform init
terraform plan -out=tfplan
terraform apply tfplan
