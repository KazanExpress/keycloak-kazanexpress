.PHONY: build start start-dev
-include .env
VERSION:=0.2.0
KC_ARG?=""
IMAGE="ghcr.io/kazanexpress/keycloak-kazanexpress:26-${VERSION}"
build:
	docker build --build-arg VERSION=${VERSION} -t ${IMAGE} .
start start-dev: build
	docker run -p 80:8080 \
	  -e KEYCLOAK_ADMIN=admin \
	  -e KEYCLOAK_ADMIN_PASSWORD=admin \
	  ${IMAGE} \
	  $@ \
	    --http-enabled=true \
		--proxy=edge \
		--hostname-strict=false ${KC_ARGS}
