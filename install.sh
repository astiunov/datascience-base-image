#!/bin/bash
locale-gen en_US.UTF-8 && update-locale && apt-get update -y && apt-get install -y bzip2 make build-essential

curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh >conda_install.sh && chmod +x conda_install.sh && ./conda_install.sh -b && rm conda_install.sh

conda install -y jupyter
conda create --name py3_env python=3 && source activate py3_env
conda install -y --file conda_requirements_py.txt
pip install -r pip_requirements.txt

conda create --name py2_env python=2 && source activate py2_env
conda install -y --file conda_requirements_py.txt
pip install -r pip_requirements.txt

conda create --name r_env && source activate r_env
conda install -y --file conda_requirements_r.txt -c r
echo 'install.packages("drat", repos="https://cran.rstudio.com"); drat:::addRepo("dmlc"); install.packages("xgboost", repos="http://dmlc.ml/drat/", type = "source")' >xgboost.R && Rscript xgboost.R

rm -rf /tmp/* xgboost.R && apt-get clean
