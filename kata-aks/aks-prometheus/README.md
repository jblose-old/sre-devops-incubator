# Used: https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/
kubectl create namespace monitoring

kubectl create -f clusterRole.yml
kubectl create -f config-map.yaml -n monitoring
kubectl create -f config-map.yml -n monitoring
kubectl create -f prometheus-deployment.yml -n monitoring
kubectl get pods --namespace=monitoring

# Connects to localhost 
kubectl port-forward <pod> 9090:9090 -n monitoring
