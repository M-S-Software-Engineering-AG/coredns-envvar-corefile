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
  targets = ["coredns-envvar-corefile", "coredns-envvar-corefile-debug"]
}

target "coredns-envvar-corefile" {
  context    = "."
  dockerfile = "Dockerfile"
  tags       = [
    "${REGISTRY}/coredns-envvar-corefile:${VERSION}",
    "${REGISTRY}/coredns-envvar-corefile:${GIT_SHA}",
    "${REGISTRY}/coredns-envvar-corefile:latest",
  ]
  platforms  = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
  ]
}

target "coredns-envvar-corefile-debug" {
  inherits = ["coredns-envvar-corefile"]
  args     = {
    BASE_IMAGE = "gcr.io/distroless/static-debian13:debug-nonroot"
  }
  tags     = [
    "${REGISTRY}/coredns-envvar-corefile:${VERSION}-debug",
    "${REGISTRY}/coredns-envvar-corefile:${GIT_SHA}-debug",
    "${REGISTRY}/coredns-envvar-corefile:latest-debug",
  ]
}
