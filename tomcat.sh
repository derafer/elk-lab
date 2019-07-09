#!/usr/bin/env bash
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp -f /vagrant/provision/elk.repo /etc/yum.repos.d/

yum install -y vim \
               java-1.8.0-openjdk.x86_64 \
               java-1.8.0-openjdk-devel.x86_64 \
               unzip \
               logstash \
               tomcat \
               git 

MY_TOMCAT="apache-tomcat-8.5.42"
WEBAPPS="/opt/tomcat/latest/webapps"
TOMCAT_PATH="/opt/tomcat/latest"
WM_IPADDR=$(hostname -I | awk '{print $2}')

# Installing tomcat; create user, group and folder
#test ! -d /opt/tomcat && mkdir /opt/tomcat
#test -z $(grep tomcat /etc/group) && groupadd tomcat
#test -z $(grep tomcat /etc/passwd) && useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
#if [[ ! -d /opt/tomcat/${MY_TOMCAT} ]]; then
#  wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.42/bin/${MY_TOMCAT}.zip
#  unzip ${MY_TOMCAT}.zip && rm -f ${MY_TOMCAT}.zip
#  mkdir -p /opt/tomcat
#  mv ${MY_TOMCAT} /opt/tomcat/
#  ln -s /opt/tomcat/${MY_TOMCAT} /opt/tomcat/latest
#  wget -O /opt/tomcat/latest/lib/tomcat-catalina-jmx-remote.jar http://repo2.maven.org/maven2/org/apache/tomcat/tomcat-catalina-jmx-remote/8.5.42/tomcat-catalina-jmx-remote-8.5.42.jar
#  chown -R tomcat: /opt/tomcat/${MY_TOMCAT}
#  chown -R tomcat: /opt/tomcat/latest
#  chmod +x /opt/tomcat/latest/bin/*.sh
#fi

# Create systemd service
#cp -f /vagrant/provision/tomcat.service /usr/lib/systemd/system/tomcat.service
#TOMCAT_PATH="/opt/tomcat/latest" sed -i 's/.*/echo & | envsubst/e' /usr/lib/systemd/system/tomcat.service
cp -f /vagrant/provision/tomcat.conf /etc/logstash/conf.d/
cp -f /vagrant/provision/grok-patterns.txt /etc/logstash/patterns


#systemctl daemon-reload
#cp /vagrant/provision/setenv.sh ${TOMCAT_PATH}/bin/setenv.sh

#if [[ $(grep -c JmxRemoteLifecycleListener $TOMCAT_PATH/conf/server.xml) ]]; then
#  sed -i '/\^*.Server port="8005".*/a \  <Listener className\=\"org.apache.catalina.mbeans.JmxRemoteLifecycleListener" rmiRegistryPortPlatform\="8097" rmiServerPortPlatform\="8098" \/\>' /opt/tomcat/latest/conf/server.xml
#fi
systemctl daemon-reload

systemctl start tomcat
#cd ${WEBAPPS}
#wget https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
#chown -R tomcat: ${WEBAPPS}
systemctl enable tomcat
