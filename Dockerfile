FROM ubuntu:xenial
MAINTAINER Alexander Tiunov <astiunov@yandex-team.ru>

COPY *.yml install.sh ./
ENV PATH="/usr/miniconda3/bin:${PATH}"
RUN ./install.sh
