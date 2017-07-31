# install common utils
apt-get install git zip

# build node from source
apt-get install make libssl-dev build-essential openssl pkg-config

# install mysql
apt-get install mysql-server && mysql_install_db && mysql_secure_installation

# installing latest stable version of nginx
cd /tmp/ && wget http://nginx.org/keys/nginx_signing.key && sudo apt-key add nginx_signing.key &&
sudo echo "deb http://nginx.org/packages/ubuntu/ $(lsb_release --codename | cut -f2) nginx" >> /etc/apt/sources.list.d/nginx.list &&
sudo echo "deb-src http://nginx.org/packages/ubuntu/ $(lsb_release --codename | cut -f2) nginx" >> /etc/apt/sources.list.d/nginx.list &&
sudo apt-get update && sudo apt-get install nginx

# install mongo 3
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 &&
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list &&
sudo apt-get update &&
sudo apt-get install -y mongodb-org

# installing keepalived from source
cd /tmp
wget http://www.keepalived.org/software/keepalived-1.2.19.tar.gz
tar zxvf keepalived*
cd keepalived*
./configure && make && make install

# create a keepalived startup script
echo 'description "load-balancing and high-availability service"' > /etc/init/keepalived.conf &&
echo 'start on runlevel [2345]' >> /etc/init/keepalived.conf &&
echo 'stop on runlevel [!2345]' >> /etc/init/keepalived.conf &&
echo 'respawn' >> /etc/init/keepalived.conf &&
echo 'exec /usr/local/sbin/keepalived --dont-fork' >> /etc/init/keepalived.conf &&
sudo mkdir -p /etc/keepalived

# install DO API tools
cd /usr/local/bin
sudo curl -LO http://do.co/assign-ip

# defining a health check for Nginx service
cd /etc/keepalived

cat << 'EOF' > keepalived.conf
vrrp_script chk_nginx {
    script "pidof nginx"
    interval 2
}

vrrp_instance VI_1 {
    interface eth1
    state MASTER
    priority 200

	virtual_router_id 33
    unicast_src_ip tor1-prod-lb1
    unicast_peer {
        tor1-prod-lb2
    }

    authentication {
        auth_type PASS
        auth_pass $KEEPALIVED_AUTH_PASSWORD
    }

    track_script {
        chk_nginx
    }

    notify_master /etc/keepalived/master.sh
}
EOF

cat << 'EOF' > master.sh
FLOATING_IP=$(curl -s http://169.254.169.254/metadata/v1/floating_ip/ipv4/ip_address)
ID=$(curl -s http://169.254.169.254/metadata/v1/id)
HAS_FLOATING_IP=$(curl -s http://169.254.169.254/metadata/v1/floating_ip/ipv4/active)

if [ $HAS_FLOATING_IP = "false" ]; then
    n=0
    while [ $n -lt 10 ]
    do
        python /usr/local/bin/assign-ip $FLOATING_IP $ID && break
        n=$((n+1))
        sleep 3
    done
fi
EOF

# make the wrapper script executable
sudo chmod +x master.sh

sudo start keepalived
