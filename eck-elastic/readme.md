# Elastic Cloud on Kubernetes

## AKS credentials

```bash
az login
az account set -s <Azure Subscription>
az aks get-credentials --name <AKS NAME> --resource-group <AKS Resource Group> --subscription <Azure Subscription>
```

## Install Steps for ES Operator

```bash
kubectl apply -f https://download.elastic.co/downloads/eck/1.3.1/all-in-one.yaml
```

## Install ES Cluster

```bash
kubectl apply -f quickstart-eck-cluster.yaml
```

## Fetch Service IP

```bash
kubectl get service quickstart-es-http
```

## Fetch Credentials

```bash
kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'
```

## Testing the Cluster

### Query the Operator

```bash
kubectl get ElasticSearch
```

### Curl the Healthcheck

```bash
curl -u "<user>:<password>" -k "https://<Service Endpoint>:9200/_cluster/health?pretty"
```

## Monitor Logs

```bash
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
```

## Reference

<https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html>
