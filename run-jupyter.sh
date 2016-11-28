#!/bin/bash
if [ "$JPY_API_TOKEN" != "" ] ; then
    echo "Starting under Jupyterhub"

    NOTEBOOK_DIR=$HOME/notebooks
    [ -n "$JPY_WORKDIR" ] && NOTEBOOK_DIR=$JPY_WORKDIR
    git clone $JPY_GITHUBURL $NOTEBOOK_DIR
    cd $NOTEBOOK_DIR
    git reset --hard $JPY_REPOPOINTER
    jupyterhub-singleuser \
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

mkdir -p $HOME/notebooks
echo "Starting Jupyter"
jupyter notebook --ip=0.0.0.0 --no-browser $JUPYTER_OPTIONS $HOME/notebooks 2>&1 | tee -a $HOME/notebooks/jupyter.log
