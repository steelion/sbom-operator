FROM alpine:3.15@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300 as alpine

ARG TARGETARCH

RUN set -eux; \
    apk add -U --no-cache ca-certificates


FROM scratch

ARG TARGETOS
ARG TARGETARCH

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY dist/sbom-operator_${TARGETOS}_${TARGETARCH}/sbom-operator /usr/local/bin/sbom-operator

ENTRYPOINT ["/usr/local/bin/sbom-operator"]
