#!/bin/bash
openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem \
    --subj "/C=DE/ST=Hamburg/L=Hamburg/O=None"
openssl x509 -text -noout -in certificate.pem
cp certificate.pem certificate-chain.pem
cat key.pem >> certificate-chain.pem
