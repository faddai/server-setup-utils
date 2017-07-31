#!/bin/bash

WEB_ROOT=/home/deploy/example.com

# to use the web root plugin, you need this
sudo -u deploy mkdir $WEB_ROOT/.well-known

############################## 
# Add to server block
##############################
# location ~ /.well-known {
#	allow all;
# }
##############################

sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
cd /opt/letsencrypt

./letsencrypt-auto certonly -a webroot --webroot-path=$WEB_ROOT -d example.com -d www.example.com

# Generate Strong Diffie-Hellman Group
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048