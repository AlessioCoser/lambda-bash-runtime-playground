#!/bin/sh

RUNTIME_NAME=bash-runtime
ZIP_NAME=runtime.zip

set -e

cd ./runtime
chmod 755 ./bootstrap
zip $ZIP_NAME bootstrap

aws lambda publish-layer-version --layer-name $RUNTIME_NAME --zip-file fileb://$ZIP_NAME