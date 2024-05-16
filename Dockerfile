FROM golang:1.22.3 AS builder
WORKDIR /src
COPY *.go go.mod go.sum tracker.db ./
RUN go mod download && \
    go mod tidy && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app


FROM alpine:latest

WORKDIR /app

COPY --from=builder /src/app /src/tracker.db /app/

ENTRYPOINT ["./app"]

