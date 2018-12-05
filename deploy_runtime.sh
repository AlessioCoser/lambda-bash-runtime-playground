#!/bin/sh

RUNTIME_NAME=$1
ZIP_NAME=runtime.zip

set -e

cd ./runtime
chmod 755 ./bootstrap
zip $ZIP_NAME bootstrap

aws lambda publish-layer-version \
  --layer-name $RUNTIME_NAME \
  --zip-file fileb://$ZIP_NAME

rm $ZIP_NAME