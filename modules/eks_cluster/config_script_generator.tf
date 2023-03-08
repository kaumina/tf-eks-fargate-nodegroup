#############################################################
# This Script will generate auxilary config enable ALB for EKS Cluster
# 1. Generating AWS LoadBalanser Service Account Yaml 
# 2. Generating config.sh script to config kubeconfig, install Helm chart for AWS Loadbalancer Add-on and Change CoreDNS annotation 
# 3. Generating AWS LoadBalanser Service Account Yaml 

############################################################
# Populate AWS ALB Controller Service Account Yaml
#############################################################

resource "local_file" "alb_yml" {
  content  = templatefile("${path.root}/templates/aws-load-balancer-controller-service-account.yaml.tftpl", {account_id= "${data.aws_caller_identity.current.account_id}"})
  filename = "files/aws-load-balancer-controller-service-account.yaml"
}

############################################################
# Generate config shell script
#############################################################

resource "local_file" "config_script" {
  filename = "files/config.sh"
  content = <<-EOT
    #!/bin/bash

    echo "Updating kubconfig"
    aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}
    echo "Installing AWS Loadbalancer Controller Service Account"
    kubectl apply -f files/aws-load-balancer-controller-service-account.yaml
    echo "Installing AWS Loadbalancer Controller Add-on with Helm"
    helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system --set clusterName=${var.cluster_name} --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller --set region=${var.region} \
    --set vpcId=${var.eks_vpc_id}
    echo "Remove CoreDNS EC2 Annotations"
    kubectl patch deployment coredns -n kube-system \
    --type=json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations", "value": "eks.amazonaws.com/compute-type"}]'
    echo "Rolling restart for CoreDNS pods"
    kubectl rollout restart -n kube-system deployment coredns


    
  EOT
}
