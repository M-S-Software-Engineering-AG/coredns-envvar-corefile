variable "REGISTRY" {
  default = "ghcr.io/m-s-software-engineering-ag"
}

variable "VERSION" {
  default = "v1.0.0"
}

variable "GIT_SHA" {
  default = "dev"
}

group "default" {
  targets = ["corefile-gen", "corefile-gen-debug"]
}

target "corefile-gen" {
  context    = "."
  dockerfile = "Dockerfile"
  tags       = [
    "${REGISTRY}/corefile-gen:${VERSION}",
    "${REGISTRY}/corefile-gen:${GIT_SHA}",
    "${REGISTRY}/corefile-gen:latest",
  ]
  platforms  = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
  ]
}

target "corefile-gen-debug" {
  inherits = ["corefile-gen"]
  args     = {
    BASE_IMAGE = "gcr.io/distroless/static-debian13:debug-nonroot"
  }
  tags     = [
    "${REGISTRY}/corefile-gen:${VERSION}-debug",
    "${REGISTRY}/corefile-gen:${GIT_SHA}-debug",
    "${REGISTRY}/corefile-gen:latest-debug",
  ]
}
