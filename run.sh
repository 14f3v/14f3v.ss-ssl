#!/bin/sh

openssl req -newkey rsa:2048 -nodes -keyout ./selfsign-ssl/privatekey.pem -x509 -days 365 -out ./selfsign-ssl/certificate.pem -subj "/CN=*.test.com"
-addext "subjectAltName=DNS:*.test.com" \
-addext "basicConstraints=critical,CA:TRUE,pathlen:0" \
-addext "keyUsage=critical,keyCertSign,cRLSign,digitalSignature"

openssl verify -CAfile ./selfsign-ssl/certificate.pem -verify_hostname '*.test.com' ./selfsign-ssl/certificate.pem
