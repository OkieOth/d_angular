#!/bin/bash

cd /opt/myproject

if ! [ -z $RUNENV ]; then
    STARTENV=--environment=$RUNENV
fi

if [ -f package.json ]; then
    if ! [ -d node_modules ]; then
        npm install
    fi
    ng serve --host 0.0.0.0 $STARTENV
else
    echo "no project found in /opt/myproject :-/"
fi
