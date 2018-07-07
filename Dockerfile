FROM golang:1.10

RUN go get -u github.com/spf13/cobra/cobra
RUN go get -v github.com/mitchellh/gox
RUN go get -u github.com/Jeffail/gabs



COPY . /go/src/github.com/odino/iploc
WORKDIR /go/src/github.com/odino/iploc

CMD bash
