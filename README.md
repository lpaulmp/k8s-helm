### Project components
The root directory presents four items:

- The presentation about the project and the main insights
- The executive file of the project
- Terraform directory that contains the infrastructure code
- Helm directory where is located the charts and the application configurations


### Kubernetes - Helm project

This repository demostrates how to deploy a kubernetes cluster in Google Cloud and an application
through helmfile,the repository uses make targets to simplify typing commands and the correct order.
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
```
cd helm
make helm-apply-dev
```

```
cd helm
make helm-apply-stage
```
