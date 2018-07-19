FROM alpine:edge
ADD files /
ENTRYPOINT /generate.sh
