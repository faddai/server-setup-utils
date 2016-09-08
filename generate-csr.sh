#!/bin/sh

# generate key
openssl genrsa -des3 -out qlsportal.com.key 2048
# remove passphrase so webserver doesn't prompt for it
openssl rsa -in qlsportal.com.key -out qlsportal.com.key
# here comes the csr
openssl req -new -key qlsportal.com.key -out qlsportal.com.csr

# alternatively, you can use this one-liner
# openssl req -new -newkey rsa:2048 -nodes -keyout qlsportal.com.key -out qlsportal.com.csr