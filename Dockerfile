FROM golang:1.22.3 AS builder

WORKDIR /src

COPY *.go go.mod go.sum ./

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

RUN go mod download && \
    go mod tidy && \
    go build -o app


FROM alpine:latest

WORKDIR /app

COPY tracker.db ./

COPY  --from=builder /src/app /app/

ENTRYPOINT ["./app"]

