# This file describes how to build hipache into a runnable linux container with all dependencies installed
# To build:
# 1) Install docker (http://docker.io)
# 2) Clone hipache repo if you haven't already: git clone https://github.com/dotcloud/hipache.git
# 3) Build: cd hipache && docker build .
# 4) Run:
# docker run -d <imageid>
# redis-cli
#
# VERSION		0.2w
# DOCKER-VERSION	0.7.1

from	docker.limecraft.com:5000/nodejs

run	echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run	apt-get -y update
run	apt-get -y install redis-server supervisor
run	mkdir -p /var/log/supervisor

add     . /opt/ 
run     cd /opt/ ; npm install && npm link
add	./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
add	./config/config_dev.json /usr/local/lib/node_modules/hipache/config/config_dev.json
add	./config/config_test.json /usr/local/lib/node_modules/hipache/config/config_test.json
add	./config/config.json /usr/local/lib/node_modules/hipache/config/config.json
expose	80
expose	6379
cmd	["supervisord", "-n"]
