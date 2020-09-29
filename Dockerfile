FROM registry.access.redhat.com/ubi8/go-toolset:latest as builder
ENV GOPATH=/go/
USER root
RUN mkdir -p /go/src/github.com/prometheus-community/jiralert
WORKDIR /go/src/github.com/prometheus-community/jiralert
RUN go get github.com/prometheus/promu
RUN git clone --progress --verbose https://github.com/prometheus-community/jiralert.git .
RUN $(go env GOPATH)/bin/promu build

FROM registry.access.redhat.com/ubi8-minimal:8.2
RUN microdnf update -y && rm -rf /var/cache/yum && microdnf install ca-certificates
WORKDIR /
COPY --from=builder /go/src/github.com/prometheus-community/jiralert/jiralert /usr/bin
ENTRYPOINT ["/usr/bin/jiralert"]
