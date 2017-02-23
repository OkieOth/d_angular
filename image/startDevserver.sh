#!/bin/bash

function checkLink() {
    if ! [ -L /usr/local/bin/$1 ]; then
        ln -s /opt/myproject/node_modules/.bin/$1 /usr/local/bin
    fi
}

cd /opt/myproject

RUN ln -s /opt/node/bin/ng /usr/local/bin && \
    ln -s /opt/node/bin/ngc /usr/local/bin && \
    ln -s /opt/node/bin/tsc /usr/local/bin && \
    ln -s /opt/node/bin/tsserver /usr/local/bin


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
    # set the links for using the application angular-cli version
    checkLink ng
    checkLink ngc
    checkLink tsc
    checkLink tsserver

    echo "start command line ..."
    echo "ng serve --host 0.0.0.0 $STARTENV $PROXY $BASEHREF $SERVER_PORT"
    ng serve --host 0.0.0.0 $STARTENV $PROXY $BASEHREF $SERVER_PORT
else
    echo "no project found in /opt/myproject :-/"
fi
