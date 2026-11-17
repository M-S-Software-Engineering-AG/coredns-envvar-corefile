# syntax=docker/dockerfile:1

ARG BASE_IMAGE=gcr.io/distroless/static-debian13:nonroot

FROM --platform=$BUILDPLATFORM golang:1.27.4-bookworm AS build
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

WORKDIR /src
COPY . .
ENV CGO_ENABLED=0 GOFLAGS=-trimpath
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH GOARM=${TARGETVARIANT#v} go build -ldflags="-s -w" -o /out/corefile-gen .

FROM $BASE_IMAGE
COPY --from=build /out/corefile-gen /corefile-gen
ENTRYPOINT ["/corefile-gen"]
