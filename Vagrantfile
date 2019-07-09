# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.define "tomcat-L1" do |web|
    web.vm.box = "sbeliakou/centos"
    web.vm.hostname = "tomcat-L1"
    web.vm.network "private_network", ip: "172.28.128.11"
    web.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
      vb.name = "tomcat-L1"
    end
    web.vm.provision :shell, path: "tomcat.sh"
  end

  config.vm.define "elastic-01", primary: true do |zbx|
    zbx.vm.box = "sbeliakou/centos"
    zbx.vm.hostname = "elastic-01"
    zbx.vm.network "private_network", ip: "172.28.128.12"
    zbx.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
      vb.name = "elastic-01"
    end
    zbx.vm.provision :shell, path: "elk.sh"
  end
end
