FROM golang:1.9-alpine as builder

WORKDIR /go/src/app

COPY . .

RUN apk --update add git
RUN go-wrapper download
RUN go-wrapper install

ENTRYPOINT ["go-wrapper", "run"]
