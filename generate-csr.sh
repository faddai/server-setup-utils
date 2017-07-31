#!/bin/sh

# generate key
openssl genrsa -des3 -out callenssolutions.com.key 2048
# remove passphrase so webserver doesn't prompt for it
openssl rsa -in callenssolutions.com.key -out callenssolutions.com.key
# here comes the csr
openssl req -new -key callenssolutions.com.key -out callenssolutions.com.csr

#https://stackoverflow.com/questions/4658484/ssl-install-problem-key-value-mismatch-but-they-do-match#17420863