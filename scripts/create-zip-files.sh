#!/bin/bash 

set -ex

TEMP_RASP_SER=pharoiot-server
TEMP_RASP_SERCLI=pharoiot-client
TEMP_MULTI_SERCLI=pharoiot-multi

mkdir download

zip -qr9 download/server.zip $TEMP_RASP_SER
zip -qr9 download/client.zip $TEMP_RASP_SERCLI
zip -qry9 download/multi.zip $TEMP_MULTI_SERCLI