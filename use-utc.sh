#!/usr/bin/sh

# use UTC on servers to avoid headaches 
# http://serverfault.com/questions/191331/should-servers-have-their-timezone-set-to-gmt-utc
sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime