Docker configuration to set up Atlassian Jira
=============================================
Inspired by https://github.com/docker-atlassian/jira

Image Contents
--------------
* Base image is postgres:9.4
* Oracle Java JDK 8
* Atlassian Jira 6.4.1
* http_proxy setup (not enabled by default)
 
Configuration
-------------
    Database Type: PostgreSQL
    Hostname: localhost
    Database: jiradb
    DBuser: postgres
