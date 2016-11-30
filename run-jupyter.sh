#!/bin/bash

NOTEBOOK_DIR=/notebooks

if [ "$JPY_API_TOKEN" != "" ] ; then
    echo "Starting under Jupyterhub"

    git clone $JPY_GITHUBURL $NOTEBOOK_DIR
    cd $NOTEBOOK_DIR
    git reset --hard $JPY_REPOPOINTER
    xvfb-run jupyterhub-singleuser \
      --port=8888 \
      --ip=0.0.0.0 \
      --user=$JPY_USER \
      --cookie-name=$JPY_COOKIE_NAME \
      --base-url=$JPY_BASE_URL \
      --hub-prefix=$JPY_HUB_PREFIX \
      --hub-api-url=$JPY_HUB_API_URL \
      --notebook-dir=$NOTEBOOK_DIR
    exit $?
fi

if [ "$JUPYTER_PORT" != "" ] ; then
    JUPYTER_OPTIONS+=" --port $JUPYTER_PORT"
fi

mkdir -p $NOTEBOOK_DIR
echo "Starting Jupyter"
xvfb-run jupyter notebook --ip=0.0.0.0 --no-browser $JUPYTER_OPTIONS $NOTEBOOK_DIR 2>&1 | tee -a $NOTEBOOK_DIR/jupyter.log
