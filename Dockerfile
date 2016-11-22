FROM ubuntu:xenial
MAINTAINER Alexander Tiunov <astiunov@yandex-team.ru>

COPY *.txt install.sh ./
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN source ./install.sh
