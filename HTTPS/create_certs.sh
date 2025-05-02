
#! /bin/bash

# The DNS name for the NGINX lab system  is passed from the command line as $1
SERVER=$1

CORPORATION=F5
GROUP=Training
CITY=SanFrancisco
STATE=CA
COUNTRY=US

# create the certificate authority 
openssl \
  req \
  -subj "/CN=$SERVER-ca/OU=$GROUP/O=$CORPORATION/L=$CITY/ST=$STATE/C=$COUNTRY" \
  -new \
  -x509 \
  -keyout ca-cert.key \
  -out ca-cert.crt \
  -days 36500 \
  -nodes

# create client private key (used to decrypt the cert we get from the CA)
openssl genrsa -out $SERVER.key

# create the CSR(Certitificate Signing Request)
openssl \
  req \
  -new \
  -subj "/CN=$SERVER/OU=$GROUP/O=$CORPORATION/L=$CITY/ST=$STATE/C=$COUNTRY" \
  -sha256 \
  -extensions v3_req \
  -reqexts SAN \
  -key $SERVER.key \
  -out $SERVER.csr \
  -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:$SERVER")) \

# sign the certificate with the certificate authority
openssl \
  x509 \
  -req \
  -days 36500 \
  -in $SERVER.csr \
  -CA ca-cert.crt \
  -CAkey ca-cert.key \
  -CAcreateserial \
  -out $SERVER.crt \
  -extfile <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:$SERVER")) \
  -extensions SAN
