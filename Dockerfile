ARG VERSION=
#ARG KEYCLOAK_VERSION=21.1.1-debian-11-r0
ARG KEYCLOAK_VERSION=26.0.0

# Build extensions.
FROM maven:3-openjdk-17 as builder
ARG VERSION
ARG KEYCLOAK_VERSION
RUN mkdir -p /src/extensions
WORKDIR /src/extensions
COPY extensions/pom.xml /src/extensions/pom.xml
RUN mvn -T 1C install && rm -rf target
COPY extensions /src/extensions
RUN mvn package

# Build Keycloak.
FROM docker.io/bitnami/keycloak:${KEYCLOAK_VERSION}
ARG VERSION
COPY --from=builder \
     /src/extensions/target/keycloak-kazanexpress-${VERSION}.jar \
     /opt/bitnami/keycloak/providers
