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






<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.33 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~>2.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | ./modules/eks_cluster | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ./modules/networking | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | `"tf_eks_fargate"` | no |
| <a name="input_enable_fargate"></a> [enable\_fargate](#input\_enable\_fargate) | Set true to enable Fargate for EKS cluster | `bool` | `false` | no |
| <a name="input_enable_nodegroup"></a> [enable\_nodegroup](#input\_enable\_nodegroup) | Set true to enable Nodegroup for EKS cluster | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment applicable | `string` | `"POC"` | no |
| <a name="input_nodegroup_scaling_config_options"></a> [nodegroup\_scaling\_config\_options](#input\_nodegroup\_scaling\_config\_options) | Pass Nodegroup scaling configs for EKS cluster valid only enable\_nodegroup is true | `map(any)` | <pre>{<br>  "desired_size": 3,<br>  "max_size": 5,<br>  "min_size": 3<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_endpoint"></a> [eks\_endpoint](#output\_eks\_endpoint) | Show EKS Endpoint |
| <a name="output_eks_id"></a> [eks\_id](#output\_eks\_id) | Show EKS ID |
| <a name="output_eks_vpc_id"></a> [eks\_vpc\_id](#output\_eks\_vpc\_id) | Show VPC ID |
| <a name="output_nodegroup_resources_name"></a> [nodegroup\_resources\_name](#output\_nodegroup\_resources\_name) | Show EKS Node Group Name |
<!-- END_TF_DOCS -->