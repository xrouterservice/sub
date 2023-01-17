#/bin/sh

nginx -g "daemon on;"
cd /app
./subconverter/subconverter
