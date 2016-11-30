FROM ubuntu:xenial
MAINTAINER Alexander Tiunov <astiunov@yandex-team.ru>

COPY *.yml install.sh install_modules.R ./
ENV PATH="/usr/miniconda3/bin:${PATH}"
RUN ./install.sh
