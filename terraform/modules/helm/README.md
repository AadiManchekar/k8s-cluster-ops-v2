We will first install metrics server as it will help us for
- CPU/Memory based horizontal autoscaling (HPA)
- Automatically adjusting/suggesting resources needed by containers (VPA)

Reference:
- https://registry.terraform.io/providers/hashicorp/helm/latest/docs
- https://artifacthub.io/packages/helm/metrics-server/metrics-server
- https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server
- https://github.com/kubernetes-sigs/metrics-server/blob/master/charts/metrics-server/values.yaml