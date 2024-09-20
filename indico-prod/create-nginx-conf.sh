#!/bin/bash

. .env

if [ -z "$NGINX_SERVER_NAME" ]
  then echo "please set NGINX_SERVER_NAME first"
  exit
fi

export NGINX_SERVER_NAME
envsubst '\$NGINX_SERVER_NAME' < nginx.conf.template > nginx.conf.$NGINX_SERVER_NAME 