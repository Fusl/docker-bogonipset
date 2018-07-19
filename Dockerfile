FROM python:alpine
ADD files /
ENTRYPOINT /generate.sh
