#!/bin/sh

CA_KEY="@@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/private/@@MENDER/CONST_CONF_SSL_SELF_CERT_NAME@@.key"
CA_CRT="@@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/certs/@@MENDER/CONST_CONF_SSL_SELF_CERT_NAME@@.crt"
CA_CSR="@@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/requests/@@MENDER/CONST_CONF_SSL_SELF_CERT_NAME@@.csr"

if ! test -f $CA_KEY; then
  mkdir -p @@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/requests
  mkdir -p @@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/private
  mkdir -p @@MENDER/CONST_CONF_SSL_CONF_DATA_DIR@@/certs

  touch $CA_KEY
  touch $CA_CRT

  openssl genrsa -out       $CA_KEY 2048
  openssl req    -new -key  $CA_KEY -out $CA_CSR -subj "/"
  openssl x509   -req -days 36500   -in  $CA_CSR -signkey $CA_KEY -out $CA_CRT
fi
