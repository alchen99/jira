#!/bin/bash

# Create /etc/apt/apt.conf if http_proxy is set
if [[ ! -z $http_proxy ]]
then
    echo "HTTP proxy = $http_proxy"
    echo "No proxy = $no_proxy"
    echo 'Acquire::http::Proxy "'$http_proxy'/";' > /etc/apt/apt.conf
fi

# update software and install python-software-properties
apt-get -y update
apt-get -y install python-software-properties

# Install Oracle Java JDK from PPA 
#    http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html

# add key for Oracle Java JDK
apt-key adv --keyserver-options http-proxy=$http_proxy --keyserver keyserver.ubuntu.com --recv EEA14886
apt-get -y update

# Auto-accept the Oracle Java JDK License then install
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
apt-get -y install libpq-dev oracle-java8-installer

# Install Atlassian Jira
sh /opt/atlassian-$AppName-$AppVer-$Arch.bin -q -varfile /opt/response.varfile
mkdir -p /opt/atlassian/jira/conf/Catalina/localhost

# Clean up
rm -f /var/cache/oracle-jdk8-installer/jdk-8*.tar.gz
rm -f /opt/atlassian-$AppName-$AppVer-$Arch.bin
apt-get clean
apt-get autoclean
apt-get autoremove
rm -f /var/lib/apt/lists/*
