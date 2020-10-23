############# builder
FROM golang:1.14.9 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-centos8-tidb
COPY . .
RUN make install-requirements && make generate && make install

############# gardener-extension-os-centos8-tidb
FROM alpine:3.12.0 AS gardener-extension-os-centos8-tidb

COPY --from=builder /go/bin/gardener-extension-os-centos8-tidb /gardener-extension-os-centos8-tidb
ENTRYPOINT ["/gardener-extension-os-centos8-tidb"]
