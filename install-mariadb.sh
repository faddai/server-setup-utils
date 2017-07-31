#!/bin/bash

apt-get install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,i386] http://mirror.fibergrid.in/mariadbrepo/10.1/ubuntu xenial main'
apt-get update
apt-get install mariadb-server
mysql_secure_installation