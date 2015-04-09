# Install Atlassian Jira
FROM postgres:9.4

MAINTAINER Alice Chen alice.chen@hp.com

# environments
ENV AppName jira
ENV AppVer 6.4.1
ENV Arch x64

# set up proxy here if required
#ENV http_proxy http://proxy.somewhere.com:8080
#ENV https_proxy http://proxy.somewhere.com:8080
#ENV ftp_proxy http://proxy.somewhere.com:8080
#ENV no_proxy 127.0.0.1, localhost

ENV DB_NAME jiradb

# Fetch the files
ADD init-database.sh /docker-entrypoint-initdb.d/
ADD ./webupd8team-java.list /etc/apt/sources.list.d/webupd8team-java.list
ADD http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.4.1-x64.bin /opt/
ADD ./install_cmds.sh /install_cmds.sh
ADD ./response.varfile /opt/response.varfile
ADD ./init.sh /init.sh

## Now Install Atlassian Jira
RUN /install_cmds.sh

# Start the service
EXPOSE 8080
CMD ["sh", "/init.sh"]
