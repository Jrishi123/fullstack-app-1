resource "aws_iam_policy" "rds_subnet_group_policy" {
  name        = "RDSSubnetGroupPolicy"
  description = "Allows managing RDS DB Subnet Groups and adding tags"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:AddTagsToResource",
          "rds:CreateDBSubnetGroup",
          "rds:DeleteDBSubnetGroup",
          "rds:ModifyDBSubnetGroup",
          "rds:DescribeDBSubnetGroups"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_rds_policy_to_rishi" {
  user       = "Rishi"  # Your IAM username here
  policy_arn = aws_iam_policy.rds_subnet_group_policy.arn
}
