# Build from the official golang image based on alpine
FROM golang:1.18-alpine AS build

# Copy the source code to a new working directory
COPY . /go/src/app
WORKDIR /go/src/app

# Build the binary
RUN go get -v -d && go build -v -o docker-demo

# Start from a clean alpine image
FROM alpine:latest
LABEL maintainer="Noah Merlis-Stephens <nmerlisstephens@mirantis.com"

# Install dependencies
RUN apk add -U --no-cache curl

# Transfer static content and binary
COPY static /static
COPY templates /templates
COPY --from=build /go/src/app/docker-demo /bin/docker-demo

# Configure image to run app
EXPOSE 8080
ENTRYPOINT ["/bin/docker-demo"]
