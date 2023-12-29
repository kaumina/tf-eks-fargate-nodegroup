#############################################################
# This Script will generate auxilary config enable ALB for EKS Cluster
# 1. Generating AWS LoadBalanser Service Account Yaml 
# 2. Generating config.sh script to config kubeconfig, install Helm chart for AWS Loadbalancer Add-on and Change CoreDNS annotation 
# 3. Generating AWS LoadBalanser Service Account Yaml 

############################################################
# Populate AWS ALB Controller Service Account Yaml
#############################################################


# Create generate Service Accounts definition yaml
resource "local_file" "alb_yml" {
  content  = templatefile("${path.root}/templates/eks-service-accounts.yaml.tftpl", { account_id = data.aws_caller_identity.current.account_id })
  filename = "files/eks-service-accounts.yaml"
}

############################################################
# Generate config shell script for NodeGroup
#############################################################

resource "local_file" "config_script_nodegroup" {
  count    = var.enable_nodegroup ? 1 : 0
  filename = "files/config_nodegroup.sh"
  content  = <<-EOT
  #!/bin/bash

  set -euo pipefail

  echo "Updating kubconfig"
  aws eks update-kubeconfig --region "${var.region}" --name "${var.cluster_name}"

  echo "Installing AWS Loadbalancer Controller Service Account"
  kubectl apply -f files/eks-service-accounts.yaml

  echo "Adding/Updating Helm Repositories"
  helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
  helm repo add eks https://aws.github.io/eks-charts
  helm repo update

  echo "Installing AWS Loadbalancer Controller Add-on with Helm"
  helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="${var.cluster_name}" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region="${var.region}" \
  --set vpcId="${var.eks_vpc_id}"

  echo "Installing AWS EBS CSI Driver self managed Add-on with Helm without "ebs-csi-controller-sa" Service Account"
  helm upgrade --install aws-ebs-csi-driver \
  --namespace kube-system \
  aws-ebs-csi-driver/aws-ebs-csi-driver
  
  echo "Update Annotation for Service Account ebs-csi-controller-sa"
  kubectl annotate serviceaccount ebs-csi-controller-sa \
  -n kube-system \
  eks.amazonaws.com/role-arn=arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKS_EBS_CSI_DriverRole

  echo "Restart ebs-csi-controller for the annotation to take effect"
  kubectl rollout restart deployment ebs-csi-controller -n kube-system

  EOT
}

############################################################
# Generate config shell script for Fargate
#############################################################

resource "local_file" "config_script_fargate" {
  count    = var.enable_fargate ? 1 : 0
  filename = "files/config_fargate.sh"
  content  = <<-EOT
  #!/bin/bash

  set -euo pipefail

  echo "Updating kubconfig"
  aws eks update-kubeconfig --region "${var.region}" --name "${var.cluster_name}"

  echo "Installing AWS Loadbalancer Controller Service Account"
  kubectl apply -f files/eks-service-accounts.yaml

  echo "Installing AWS Loadbalancer Controller Add-on with Helm"
  helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="${var.cluster_name}" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region="${var.region}" \
  --set vpcId="${var.eks_vpc_id}"

  echo "Remove CoreDNS EC2 Annotations for Fargate"
  kubectl patch deployment coredns -n kube-system \
  --type=json \
  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations", "value": "eks.amazonaws.com/compute-type"}]'

  echo "Rolling restart for CoreDNS pods after annotation removal"
  kubectl rollout restart -n kube-system deployment coredns
      
  EOT
}
