#!/bin/bash
#
# Deploy node.js, mongo DB and associated other requirements for Debain Wheezy server
# create this script in /usr/local/sbin/ and then run chmod 755 /usr/local/sbin/truxieServerSetup.sh
# --------------------------------------------------------------------------
#

# exit

# here's what we need to use nodetime with ed@truxie and milo  
# require('nodetime').profile({
    # accountKey: '3faeb1c8527a8d07093d30548b137f5434b754ec', 
    # appName: 'truxie api'
  # });

apt-get update
apt-get upgrade

# install ntp server - twitter api is really picky about timestamp of incoming requests.
# add all kinds of other prereqs to installing node or nginx
apt-get install ntp ntpdate build-essential curl git-core openssl libssl-dev

# nginx prereqs
apt-get install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev

# lets get monit on here as well...
apt-get install monit

# tell monit that it should look for monit config files in the /etc/monit.d/* folder
echo 'include /etc/monit.d/*' >> /etc/monit/monitrc


# put a file like this in /etc/monit/conf.d/ and name it myapp
# #!monit
# set logfile /var/log/monit.log
# 
# check host myapp with address 127.0.0.1
    # start program = "/etc/init.d/myapp start"
    # stop program  = "/etc/init.d/myapp stop"
    # if failed port 8000 protocol HTTP
        # request /
        # with timeout 10 seconds
        # then restart


# we could edit the monitrc file here.
# and then tell monit that it should look for monit config files in the /etc/monit.d/* folder
# echo '   include /etc/monit.d/*' >> /etc/monit/monitrc


mkdir /usr/local/sbin/nginxsource
cd /usr/local/sbin/nginxsource
wget http://nginx.org/download/nginx-1.4.1.tar.gz
tar -zxvf nginx-1.4.1.tar.gz
cd /usr/local/sbin/nginxsource/nginx-1.4.1/

# added --with-ipv6

./configure --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-ipv6

#./configure --with-http_ssl_module --with-http_stub_status_module --with-http_gzip_static_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-ipv6
#./configure --prefix=/usr --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/lock/nginx.lock --with-http_ssl_module --user=www-data --group=www-data --with-http_stub_status_module --with-http_gzip_static_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-ipv6
    
make
sudo make install


cd /usr/local/sbin/

# install nginx and hell, start it.  probably need to configure it as well, but you can do that later.
#apt-get install nginx
#/etc/init.d/nginx start

git clone https://github.com/joyent/node.git
cd node
 
# 'git tag' shows all available versions: select the latest stable.
git checkout v0.10.18
 
# Configure seems not to find libssl by default so we give it an explicit pointer.
# Optionally: you can isolate node by adding --prefix=/opt/node
./configure --openssl-libpath=/usr/lib/ssl
make
# wtf is this for?
make test  
sudo make install
node -v # it's alive!
 
# Luck us: NPM is packaged with Node.js source so this is now installed too
npm -v # it's alive!

# install coffee script globally
npm -g install coffee-script

# we use the new pm2 instead of forever.js
npm install -g pm2

# install mongodb
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install mongodb-10gen

# run 
cd /srvusr/


# edit   index.html to add your server IP address --> var socket = io.connect('http://<your server address here>:8080');


