#!/bin/bash 

set -ex

TEMP_RASP_SER=pharoiot-server
TEMP_RASP_SERCLI=pharoiot-client
TEMP_MULTI_SERCLI=pharoiot-multi

mkdir download

zip -qr download/server.zip $TEMP_RASP_SER
zip -qr download/client.zip $TEMP_RASP_SERCLI
zip -qry download/multi.zip $TEMP_MULTI_SERCLI