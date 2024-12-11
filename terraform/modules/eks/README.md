aws_eks_node_group needs EKS cluster to be up and running else you will get following error
```
Error: creating EKS Node Group operation error EKS: CreateNodegroup, https response error StatusCode: 404, api error ResourceNotFoundException: No cluster found for name:
```


Following policy should be attached to worker node role which will allow it to connect to EKS
- AmazonEKSWorkerNodePolicy
- AmazonEKS_CNI_Policy
- AmazonEC2ContainerRegistryReadOnly

if your worker nodes arent connecting with EKS control-plane or you see error "NodeCreationFailure: Instances failed to join the kubernetes cluster"
then check out
- https://repost.aws/knowledge-center/eks-worker-nodes-cluster