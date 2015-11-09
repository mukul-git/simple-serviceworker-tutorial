#!/usr/bin/env /bin/bash

THIS_FILE=`readlink -f $0`
THIS_DIR=`dirname $THIS_FILE`

OPENSSL_CONFIG=$THIS_DIR/openssl.conf
PRIVATE_KEY=$THIS_DIR/privateKey.key
REQ=$THIS_DIR/req.pem
PUBLIC_KEY=$THIS_DIR/publicKey.pem
LOCAL_CA_CONF=/opt/webIDESecurityInfra/ca.conf

rm -f $PRIVATE_KEY $PUBLIC_KEY $REQ

openssl genrsa -out $PRIVATE_KEY 2048

openssl req -new -key $PRIVATE_KEY -config $OPENSSL_CONFIG -out $REQ

#openssl x509 -req -days 3650 -in $REQ -signkey $PRIVATE_KEY -out $PUBLIC_KEY

openssl ca -in $REQ -out $PUBLIC_KEY -config $LOCAL_CA_CONF
