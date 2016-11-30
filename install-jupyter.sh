#!/bin/bash

apt-get install -y -q \
    curl \
    xvfb \
    wget \
    vim \
    zlib1g-dev \
    git \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy \
    npm

npm install -g configurable-http-proxy

conda env update -n root --file jupyter_req.yml

source activate py3_env
conda install -y ipykernel && python -m ipykernel install

source activate py2_env
conda install -y ipykernel && python -m ipykernel install

source activate r_env
conda install -c r r-irkernel
echo 'IRkernel::installspec(user = FALSE)' >r_kernel.R && Rscript r_kernel.R

source deactivate

rm -rf r_kernel.R /tmp/* jupyter_req.yml
