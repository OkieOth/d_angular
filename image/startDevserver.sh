#!/bin/bash

cd /opt/myproject

if ! [ -z $ENVIRONMENT ]; then
    echo "devserver using environment: $ENVIRONMENT"
    STARTENV="--environment=$ENVIRONMENT"
fi

if ! [ -z $BASE_HREF ]; then
    echo "devserver using base-href: $BASE_HREF"
    BASEHREF="--base-href=$BASE_HREF"
fi

if ! [ -z $PROXYCONF ]; then
    echo "devserver using proxy conf: $PROXYCONF"
    PROXY="--proxy-conf=$PROXYCONF"
fi

if ! [ -z $PORT ]; then
    echo "devserver using port: $PORT"
    SERVER_PORT="--port=$PORT"
fi

if [ -f package.json ]; then
    if ! [ -d node_modules ]; then
        npm install
    fi
    echo "start command line ..."
    echo "ng serve --host 0.0.0.0 $STARTENV $PROXY $BASEHREF $SERVER_PORT"
    ng serve --host 0.0.0.0 $STARTENV $PROXY $BASEHREF $SERVER_PORT
else
    echo "no project found in /opt/myproject :-/"
fi
