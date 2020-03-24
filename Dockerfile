FROM alpine:3.11

COPY app /usr/local/bin/

CMD ["/usr/local/bin/app"]