FROM golang:alpine AS builder
ENV VERSION=1.5.0
WORKDIR /app/
ENV CGO_ENABLED=0
RUN wget -O delve.tar.gz https://github.com/go-delve/delve/archive/v${VERSION}.tar.gz && \
        tar -xzvf delve.tar.gz && \
        cd delve-${VERSION} && \
        go install ./cmd/dlv

FROM alpine
COPY --from=builder /go/bin/dlv /usr/local/bin/dlv
ENTRYPOINT ["/usr/local/bin/dlv"]
