PHONY : dev-deploy stage-deploy

.DEFAULT_GOAL = help

require-%:
		@ if [ "${${*}}" = "" ]; then \
				echo "ERROR: Environment variable not set: \"$*\""; \
			exit 1; \
			fi

# Helm test dry run
helm-dry-run-chart:
	cd Charts/nginx-demo && helm install --dry-run nginx-demo ./

# helmfile sync
helmfile-sync:
	helmfile sync

# Deploy nginx demo in Dev namespace
helmfile-dev-apply:
	helmfile -e dev apply

# Deploy nginx demo in Stage namespace
helmfile-stage-apply:
	helmfile -e stage apply

# Login gcloud
gcloud-login:
	gcloud auth login

# install Helm secrets plugin
helm-plugin-install-secrets:
	helm plugin install https://github.com/jkroepke/helm-secrets --version v3.4.0

# Install helm diff
helm-plugin-install-diff:
	helm plugin install https://github.com/databus23/helm-diff --version v3.1.3

# Encrypt secrets with helm secrets
helm-encrypt: require-FILE_PATH
	helm secrets enc ${FILE_PATH}

# Decrypt secrets with helm secrets
#
helm-decrypt: require-FILE_PATH
	helm secrets dec ${FILE_PATH}

# Create a KMS on GCE
generate-sop-kme-gce:
	gcloud kms keyrings create pm-sops --location global
	gcloud kms keys create sops-key --location global --keyring pm-sops --purpose encryption
	gcloud kms keys list --location global --keyring pm-sops

# Create sope config file
sop-template-configuration:
	cat < EOF > .sops.yaml
	creatin_rule:
	- gcp_kms: <FILL_IT>
	EOF
