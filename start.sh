#/bin/bash

nohup /app/subconverter/subconverter &

nginx -g "daemon off;"

netstat -anlp |grep 155