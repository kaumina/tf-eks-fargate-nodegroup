# About this repo

This repository contains Terraform code for provisioning EKS infrastructure using AWS provider. Enable Fargate or Nodegroup as you wish by setting boolean values in **enable_fargate/enable_nodegroup** in `variable.tf`

## Prerequisites

Before running the Terraform code, you will need to:

- Have [Terraform](https://www.terraform.io/downloads.html) installed locally.
- Set up AWS credentials with necessary permissions to create and manage resources.
- Install the following Terraform providers:
  - `local` > 2.3.0
  - `tls` > 4.0.4
  - `aws` > 4.53.0

## Getting Started

To use this Terraform code:
1. Update your AWS key id and access key in credentials file
2. Clone and set boolean values to enable_fargate/enable_nodegroup in `variable.tf`
3. Execute the Terraform
4. Execute the shell script (files/config_nodegroup.sh or files/config_fargate.sh) to configure the cluster

## Variables

| Variable Name                  | Description                                                                                          | Type       | Default Value |
| ------------------------------ | ---------------------------------------------------------------------------------------------------- | ---------- | ------------- |
| enable_fargate                 | Set true to enable Fargate for the EKS cluster                                                       | bool       | true          |
| enable_nodegroup               | Set true to enable Nodegroup for the EKS cluster                                                      | bool       | false         |
| nodegroup_scaling_config_options | Pass Nodegroup scaling configs for the EKS cluster. This variable is valid only if enable_nodegroup is true. | map(any)   | { desired_size = 3, max_size = 5, min_size = 3 } |
| region                         | The AWS region where the EKS cluster will be created.                                                 | string     | us-west-2     |
| cluster_name                   | The name of the EKS cluster to be created.                                                            | string     | tf_eks_fargate |
| environment                    | The environment where the EKS cluster will be created.                                                | string     | POC           |





