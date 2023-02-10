ARG VERSION=
ARG KEYCLOAK_VERSION=20.0.3

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

# Configure Keycloak.
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} as keycloak
ARG VERSION
ARG KEYCLOAK_VERSION
COPY --from=builder \
     /src/extensions/target/keycloak-kazanexpress-${VERSION}.jar \
     /opt/keycloak/providers/
COPY themes/kazanexpress/ /opt/keycloak/themes/kazanexpress/
RUN /opt/keycloak/bin/kc.sh build \
    --db=postgres \
    --metrics-enabled=true \
    --features=scripts

# Build Keycloak.
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
ARG VERSION
ARG KEYCLOAK_VERSION
COPY --from=keycloak /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=keycloak /opt/keycloak/providers/ /opt/keycloak/providers/
# TODO: enable theme copying when theme will be ready
# COPY --from=keycloak /opt/keycloak/themes/ /opt/keycloak/themes/
WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
