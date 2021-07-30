# K8s, Juiceshop & Check Point Appsec

## Overview
This repository installs K8s on AKS with Terraform, deploys Juiceshop and secures it with Check Point Appsec

## Prerequisites


## Usage

1. Clone the repository

2. Create a set_env_var.sh file and add the below content with your ARM credentials:
```
export ARM_CLIENT_ID="<Azure Client ID>"
export ARM_CLIENT_SECRET="<Azure Client Secret>"
export ARM_SUBSCRIPTION_ID="<Azure Subscription ID>"
export ARM_TENANT_ID="<Azure Tenant ID>"
export ARM_ACCESS_KEY="<Azure Storage Account Secret>"
``` 

3. From a command line, set your environment variables to access Azure
> ```
> source ./set_env_var.sh
>```

4. Deploy K8s
> ```
> cd aks
> terraform init
> terraform apply
>```

5. Get the K8s configuration from the Terraform state and store it in a file that kubectl can read & Set an environment variable so that kubectl picks up the correct config
> ```
> echo "$(terraform output kube_config)" > ./kubeconfig
> export KUBECONFIG=./kubeconfig
>```

6. Verify the health of the cluster
> ```
> kubectl get nodes
>```

7. Create namespace
> ```
> kubectl create namespace appsec-kube
> kubectl config set-context --current --namespace=appsec-kube
>```

8. Deploy Juiceshop
> ```
> kubectl apply -f ../juiceshop/juice-shop.yaml
>```

9. Deploy Appsec
> ```
> helm repo add cpAppSec https://raw.githubusercontent.com/CheckPointSW/Infinity-Next/main/deployments
> helm search repo -l
> helm install cpappsec cpAppSec/cpappsec --set agentToken="{your nanoToken}" --set platform="AKS"
>```

10. Configure Ingress & Secret
> ```
> kubectl apply -f ../juiceshop/juice-shop-secret.yaml
> kubectl apply -f ../juiceshop/juice-shop-ingress.yaml
>```

## Access Juiceshop

Get the Load Balancer external IP
> ```
> kubectl get svc
> ```

Get the Host domain from the ingress configuration
> ```
> kubectl get ingress
>```

Browse to the Host domain to access Juiceshop
https://juice.cpappsec.site/

## Cleanup
> ```
> terraform destroy
>```

Optional: cleanup services
> ```
> kubectl delete namespace appsec-kube
> helm uninstall cpappsec
> kubectl delete -f juice-shop.yaml --namespace appsec-kube
> ```