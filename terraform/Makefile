.PHONY : init plan apply generate-kubeconfig kube-dashboard kube-dashboard-access kube-dashboard-token kube-namespace-dev kube-namespace-stage

.DEFAULT_GOAL = help

export PROJECT_NAME ?= kubernetes-helm

require-%:
	@ if [ "${${*}}" = "" ]; then \
			echo "ERROR: Environment variable not set: \"$*\""; \
			exit 1; \
		fi

## Terraform init
init:
	terraform init

## terraform plan
plan:
	terraform plan -out=tfplan.out

## terraform apply
apply:
	terraform apply

## terraform destroy
destroy:
	terraform apply

## Generate Kubeconfig
generate-kubeconfig:
	@gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name)

## Create the dashboard
kube-dashboard:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

## Open kube proxy open the browser http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy
kube-proxy:
	kubectl proxy

## Authenticate in the kubernetes dashboard creating the accesses
kube-dashboard-access:
	kubectl apply -f  kubernetes-configs/kubernetes-dashboard-admin.rbac.yaml

## Generate the token to get access to the Kube token
kube-dashboard-token:
	@kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')

## Create namespaces for the applications Dev
kube-namespace-dev:
	kubectl create namespace dev


## Create namespaces for the applications Dev
kube-namespace-stage:
	kubectl create namespace stage

## Using this approach https://gist.github.com/prwhite/8168133#gistcomment-2278355
help:
		echo "Please use \`make <target>' where <target> is one of\n\n"
		awk '/^[a-zA-Z\-\_0-9]+:/ { \
				helpMessage = match(lastLine, /^## (.*)/); \
				if (helpMessage) { \
					helpCommand = substr($$1, 0, index($$1, ":")); \
					helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
					printf "%-30s %s\n", helpCommand, helpMessage; \
				} \
		} \
		{ lastLine = $$0 }' $(MAKEFILE_LIST)
