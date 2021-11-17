.PHONY: build
build: 
	@scripts/build

.PHONY: build_infra
build_infra:
	@scripts/build_infra

.PHONY: config_ingress
config_ingress:
	@scripts/config_ingress

.PHONY: auth
auth:
	@scripts/export_config

.PHONY: deploy_app
deploy_app:
	@scripts/deploy_app

.PHONY: destroy
destroy:
	@scripts/destroy_env
