# setup_eks

To identify a cluster's subnets, the Kubernetes Cloud Controller Manager (cloud-controller-manager) and AWS Load Balancer Controller (aws-load-balancer-controller) query the cluster's subnets by using the following tag as a filter:

kubernetes.io/cluster/cluster-name

Reference Link https://aws.amazon.com/premiumsupport/knowledge-center/eks-vpc-subnet-discovery/

cidrsubnet calculates a subnet address within given IP network address prefix.
cidrsubnet(prefix, newbits, netnum)
