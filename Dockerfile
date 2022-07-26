FROM alpine:3.16

COPY app /usr/local/bin/

CMD ["/usr/local/bin/app"]
