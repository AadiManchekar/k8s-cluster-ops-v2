# k8s-cluster-ops-v2

## Run the project
Pre-requisite: terraform CLI and aws CLI installed
1. Configure aws cli
```
aws configure --profile=mocha
```
2. Now follow the steps in terraform/backend/README.md
3. To run the project
```
cd terraform
make
```
4. Once the cluster is created
```
aws eks update-kubeconfig --region <aws-region> --name <cluster-name> --profile <profile-name> (here its mocha)

kubectl auth can-i "*" "*"

kubectl get nodes --show-labels
```
5. Check if metrics server is up
```
kubectl get pods -n kube-system
```
check if you can see a metrics-server pod
```
kubectl logs -n kube-system -f <metrics-server-pod-name> (for me it was: metrics-server-857b487695-5dhk6)
```
validate if u can get the top nodes
```
kubectl top pods -A
```


## Challenges
1. Storing state in s3 for 3 AZ replication
2. using common folder for shared provider configuration and backend state management as tf treats all folders as independent modules.
so if we didnt had the common folder, we couldnt share the providers and backend state and we would require to add providers and backend state in all folders we create.
i used terraform_remote_state, it isn't for storage of your state its for retrieval in another terraform plan if you have outputs. 
later i saw tf modules which is way better https://stackoverflow.com/questions/58547168/using-terraform-remote-state-in-s3-with-multiple-folders
3. aws_eks_node_group needs EKS cluster to be up and running else you will get following error
```
Error: creating EKS Node Group operation error EKS: CreateNodegroup, https response error StatusCode: 404, api error ResourceNotFoundException: No cluster found for name:
```
4. I missed adding AmazonEC2ContainerRegistryReadOnly policy to worker node role, due to which worker nodes were not able to connect to EKS control-plane
```
Error: creating EKS Node Group operation error EKS: CreateNodegroup, https response error StatusCode: 404, api error ResourceNotFoundException: No cluster found for name:
```
