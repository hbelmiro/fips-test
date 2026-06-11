ARG GO_TOOLSET_IMAGE=registry.access.redhat.com/ubi9/go-toolset:1.26.3

FROM --platform=$BUILDPLATFORM ${GO_TOOLSET_IMAGE} AS builder

ARG GOFIPS140=v1.0.0
ARG BUILD_TAGS=no_openssl
ARG TARGETOS=linux
ARG TARGETARCH=amd64

USER root
WORKDIR /workspace

COPY go.mod ./
COPY main.go ./

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GOFIPS140=${GOFIPS140} \
    go build -tags ${BUILD_TAGS} -o /bin/fips-test .

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.5

ARG GODEBUG_VALUE=
ENV GODEBUG=${GODEBUG_VALUE}

COPY --from=builder /bin/fips-test /bin/fips-test

ENTRYPOINT ["/bin/fips-test"]
