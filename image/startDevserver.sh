#!/bin/bash

cd /opt/myproject

if [ -f package.json ]; then
    if ! [ -d node_modules ]; then
        npm install
    fi
    ng serve --host 0.0.0.0
else
    echo "no project found in /opt/myproject :-/"
fi
