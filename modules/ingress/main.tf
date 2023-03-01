
####################################################
# Installing the AWS Load Balancer Controller add-on
####################################################

data "aws_caller_identity" "current" {}

# Create "AWSLoadBalancerControllerIAMPolicy" IAM Policy with pre downloaded policy JSON

resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
  name   = "example-policy"
  policy = "${file("files/iam_policy.json")}"
}

# Create load-balancer-role-trust-policy.json for the assume-role

resource "aws_iam_role" "AmazonEKSLoadBalancerControllerRole" {
  name = "AmazonEKSLoadBalancerControllerRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:aud": "sts.amazonaws.com",
                    "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

# Attach the required Amazon EKS managed IAM policy to the IAM role.

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.AmazonEKSLoadBalancerControllerRole.name
  policy_arn = aws_iam_policy.AWSLoadBalancerControllerIAMPolicy.arn
}

