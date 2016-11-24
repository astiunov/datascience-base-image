# datascience-base-image

[![Build Status](https://travis-ci.org/astiunov/datascience-base-image.svg?branch=master)](https://travis-ci.org/astiunov/datascience-base-image)

Docker image for data science in Ya.Contest. Installs jupyter and 3 conda environments:
* py3_env with python3
* py2_env with python2
* r_env with R (+ xgboost)

See *env.yml for a packages' details.

Use ```make build``` to build an image.
