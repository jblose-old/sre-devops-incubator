


# Installed Helm
helm install stable/nginx-ingress --namespace kube-system --set controller.replicaCount=2


# Create Service Account for tiller
kubectl apply -f helm-rbac.yml


# For securing Helm and Tiller see ./security