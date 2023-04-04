# Terraform README

This repository contains Terraform code for provisioning EKS infrastructure using AWS provider. 

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
2. Clone and execute the Terraform
3. Execute the shell script (files/config.sh) to configure the cluster






