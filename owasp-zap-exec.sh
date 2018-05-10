#!/bin/bash
# Original code
#  OWASP ZAP2\.7でzap\-cliを使ってScan実行 \- 備忘録／にわかエンジニアが好きなように書く
#  http://www.n-novice.com/entry/2017/12/21/072852

# OWASP ZAP container name
OWASPZAP_CONTAINER_NAME=owaspzapcontainer
# Target service container name
TARGET_CONTAINER=$2

# Start daemon
docker run --name $OWASPZAP_CONTAINER_NAME --link TARGET_CONTAINER -v $(pwd):/zap/wrk/:rw -u root -p 8080:8080 -i -d owasp/zap2docker-weekly /zap/wrk/zapinit.sh

# Wait 
sleep 10

#target
TARGET_URL=$1


#SCAN start
docker exec $OWASPZAP_CONTAINER_NAME zap-cli -p 8080 status
docker exec $OWASPZAP_CONTAINER_NAME zap-cli -p 8080 open-url $TARGET_URL
docker exec $OWASPZAP_CONTAINER_NAME zap-cli -p 8080 spider $TARGET_URL
docker exec $OWASPZAP_CONTAINER_NAME zap-cli -p 8080 active-scan -r $TARGET_URL

#Output
docker exec $OWASPZAP_CONTAINER_NAME zap-cli -p 8080 alerts
docker exec $OWASPZAP_CONTAINER_NAME zap-cli report -f xml -o /zap/wrk/testreport_$(date +%Y%m%d).xml
