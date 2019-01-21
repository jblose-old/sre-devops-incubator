# For setting up an AKS cluster it is requiered to create a Service Principle
# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest
az ad sp create-for-rbac --skip-assignment


# When needed:
# To install kubectl for Azure
az aks install-cli
# Configure AKS Credentials into local .kube
az aks get-credentials --resource-group <AKS Resource Group> --name <AKS Cluster Name>
# Launches Dashboard
az aks browse --resource-group <AKS Resource Group> --name <AKS Cluster Name>