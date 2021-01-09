FROM golang:1.15.6 as builder

ENV  GOPROXY direct

WORKDIR /go/src

COPY main.go ./
COPY go.mod go.sum ./
RUN go mod download

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64
RUN go build \
    -o /go/bin/main \
    -ldflags '-s -w'

FROM scratch as runner

COPY --from=builder /go/bin/main /app/main

ENTRYPOINT ["/app/main"]
