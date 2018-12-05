#!/bin/bash
function setRuntimeArn () {
  withQuotes=`aws lambda get-layer-version --layer-name ${1} --version-number ${2} | grep LayerArn | awk '{print $2}'`
  withoutFirstQuote=${withQuotes#'"'}
  RUNTIME_ARN=${withoutFirstQuote%'"'}
}

function setRoleArn () {
  withQuotes=`aws iam get-role --role-name $ROLE_NAME | grep Arn | awk '{print $2}'`
  withoutFirstQuote=${withQuotes#'"'}
  ROLE_ARN=${withoutFirstQuote%'"'}
}

set -e

ROLE_ARN=''
RUNTIME_ARN=''
ZIP_NAME='function.zip'
ROLE_NAME=$1
RUNTIME_NAME=$2
RUNTIME_VERSION="$3"
FUNCTION_NAME="$4"

setRuntimeArn $RUNTIME_NAME $RUNTIME_VERSION
setRoleArn $ROLE_NAME

echo $ROLE_ARN
echo $RUNTIME_ARN
echo $ZIP_NAME
echo $ROLE_NAME
echo $RUNTIME_NAME
echo $FUNCTION_NAME
echo $RUNTIME_VERSION

cd ./function
chmod 755 ./*
zip $ZIP_NAME ./*

aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --zip-file fileb://$ZIP_NAME \
  --handler function.handler \
  --runtime provided \
  --role $ROLE_ARN \
  --layers $RUNTIME_ARN:$RUNTIME_VERSION

rm $ZIP_NAME