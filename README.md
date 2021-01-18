### Kubernetes - Helm project

This repository demostrates how to deploy a kubernetes cluster in Google Cloud and
how to continues deployement is availble through CircleCI tool,
---the repository uses make targets to simplify typing commands and the correct order.
these are the steps to create from scratch a Kubernetes cluster and services:

#### Deploy Kubernetes cluster with Terraform

The cluster is initialized using terraform 0.14.4 version, the secrets stored in terraform.tfvars are not commited
in this repository for security of the project due to the initializacion of the cluster happens one time
I'm going to skip how to share the secrete variables with others.

Initialize terraform:
```
terraform  init
```

Terraform plan and create the cluster applying the plan
```
terraform plan && terraform apply
```

##### Configure the Kubernetes and create the Kube dashboard
For easy managment I ceated the kubebernetes dashboard using the google templastes available in the internet, the kubeconfig is generated through the gcloud CLI.
As part of the configuration we are going to generate the kube-dashboard to visualize the components using the google templates recommended.
Following the order in the Makefile makes the process run in order.

#### Create the helmfiles
In the directory there are two environments one containing the dev and the other stage environments, the example include a secret encrypted and a value passed to as part of the of the image.

Following the Make targets get a helm chart deployed by helmfile
