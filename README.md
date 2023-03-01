# tf-eks-fargate[DRAFT]
Clone the reporsitory


Create Install the AWS Load Balancer Controller Service Account

Install Install the AWS Load Balancer Controller

Change CoreDNS pot annotation to reflect Faragate

`kubectl patch deployment coredns -n kube-system --type=json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations", "value": "eks.amazonaws.com/compute-type"}]'`

`kubectl rollout restart -n kube-system deployment coredns`

Create Fargate profile

References:
https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
