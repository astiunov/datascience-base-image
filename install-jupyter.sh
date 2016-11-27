#!/bin/bash

conda install -y jupyter

source activate py3_env
conda install -y ipykernel && python -m ipykernel install

source activate py2_env
conda install -y ipykernel && python -m ipykernel install

source activate r_env
conda install -c r r-irkernel
echo 'IRkernel::installspec(user = FALSE)' >r_kernel.R && Rscript r_kernel.R

source deactivate
apt-get install -y xvfb

rm -rf r_kernel.R /tmp/* install-jupyter.sh
