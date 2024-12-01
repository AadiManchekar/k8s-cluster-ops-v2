Reference:
- https://aws.github.io/aws-eks-best-practices/networking/subnets/#eks-cluster-architecture
- https://aws.github.io/aws-eks-best-practices/networking/subnets/#eks-control-plane-communication
- https://aws.github.io/aws-eks-best-practices/networking/subnets/#vpc-configurations

### EKS arch

An EKS cluster consists of two VPCs:

    An AWS-managed VPC that hosts the Kubernetes control plane. This VPC does not appear in the customer account.
    A customer-managed VPC that hosts the Kubernetes nodes. This is where containers run, as well as other customer-managed AWS infrastructure such as load balancers used by the cluster


The nodes in the customer VPC need the ability to connect to the managed API server endpoint in the AWS VPC. This allows the nodes to register with the Kubernetes control plane and receive requests to run application Pods.

The nodes connect to the EKS control plane through (a) an EKS public endpoint or (b) a Cross-Account elastic network interfaces (X-ENI) managed by EKS.

As the node starts, the EKS bootstrap script is executed and Kubernetes node configuration files are installed. As part of the boot process on each instance, the container runtime agents, kubelet, and Kubernetes node agents are launched.


### EKS VPC

To register a node, Kubelet contacts the Kubernetes cluster endpoint. It establishes a connection with either the public endpoint outside of the VPC or the private endpoint within the VPC. Kubelet receives API instructions and provides status updates and heartbeats to the endpoint on a regular basis.

Kubernetes API requests that originate from within your cluster’s VPC (such as worker node to control plane communication) leave the VPC, but not Amazon’s network. In order for nodes to connect to the control plane, they must have a public IP address and a route to an internet gateway or a route to a NAT gateway where they can use the public IP address of the NAT gateway.

A VPC must have an IPv4 CIDR block associated with it. The allowed block size is between a /16 prefix (65,536 IP addresses) and /28 prefix (16 IP addresses). 


### EKS routing

Kubernetes worker nodes can run in either a public or a private subnet. Whether a subnet is public or private refers to whether traffic within the subnet is routed through an internet gateway. Public subnets have a route table entry to the internet through the internet gateway, but private subnets don't.

The traffic that originates somewhere else and reaches your nodes is called ingress. Traffic that originates from the nodes and leaves the network is called egress. Nodes with public or elastic IP addresses (EIPs) within a subnet configured with an internet gateway allow ingress from outside of the VPC. Private subnets usually have a routing to a NAT gateway, which do not allow ingress traffic to the nodes in the subnets from outside of VPC while still allowing traffic from the nodes to leave the VPC (egress).

Instantiating nodes in private subnets offers maximal control over traffic to the nodes and is effective for the vast majority of Kubernetes applications. Ingress resources (like as load balancers) are instantiated in public subnets and route traffic to Pods operating on private subnets.