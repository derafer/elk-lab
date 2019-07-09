#!/usr/bin/env bash

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp /vagrant/provision/elk.repo /etc/yum.repos.d/

yum install -y elasticsearch kibana vim tmux

WM_IPADDR=$(hostname -I | awk '{print $2}')

sed -i 's/#server\.host: "localhost"/server\.host: "172.28.128.12"/g' /etc/kibana/kibana.yml
#sed -i 's/.*/echo & | envsubst/e' /etc/kibana/kibana.yml
systemctl daemon-reload
systemctl enable elasticsearch.service kibana.service
systemctl start elasticsearch.service kibana.service