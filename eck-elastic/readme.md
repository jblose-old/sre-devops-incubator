
# AKS credentials
```bash
az login
az account set -s <Azure Subscription>
az aks get-credentials --name <AKS NAME> --resource-group <AKS Resource Group> --subscription <Azure Subscription>
```

# Install Steps for ES Operator
kubectl apply -f https://download.elastic.co/downloads/eck/1.3.1/all-in-one.yaml

# Install ES Cluster
kubectl apply -f eck-cluster.yaml

# Monitor Logs
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator

# Reference 
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html