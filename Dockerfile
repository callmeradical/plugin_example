FROM golang:1.9.1-alpine

RUN apk add --update git build-base

RUN mkdir /source
RUN mkdir -p /go/src/github.com/callmeradical
