We will be using "AWS VPC CNI Plugin"

- AmazonEKSClusterPolicy: This policy provides Kubernetes the permissions it requires to manage resources on your behalf

- AmazonEKS_CNI_Policy: This policy provides the Amazon VPC CNI Plugin (amazon-vpc-cni-k8s) the permissions it requires to modify the IP address configuration on your EKS worker nodes

- AmazonEKSWorkerNodePolicy: This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.


Why Pod Identity Is Better Than IRSA

1. Granularity: 
- IRSA is Service account level (applies to all pods using it).	
- Pod Identity is at Pod level (each pod can assume a unique IAM role).

2. Least Privilege:
- IRSA requires careful scoping at service account level.	
- Pod Identity is more secure; roles can be tied to individual pods.

3. Flexibility:	
- IRSA is Suitable for simple use cases.	
- Pod Identity is Ideal for complex setups requiring fine-grained control.


Reference:
- https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEKSClusterPolicy.html
- https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEKS_CNI_Policy.html
- https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEKSWorkerNodePolicy.html
- https://docs.aws.amazon.com/eks/latest/userguide/cluster-iam-role.html