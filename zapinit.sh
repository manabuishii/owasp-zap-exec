#!/bin/bash

# Zap waiting for Spider endlessly when it crashed. · Issue #4428 · zaproxy/zaproxy 
# https://github.com/zaproxy/zaproxy/issues/4428
#
# Fix CACHE SIZE 
sed -i "s/SET FILES CACHE SIZE 10000/SET FILES CACHE SIZE 100000/" db/zapdb.script

# Start zap
zap.sh -daemon -host 0.0.0.0 -port 8080 -config api.disablekey=true -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true
