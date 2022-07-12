# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "shital191099@gmail.com" 
COPY /webapp/target/*.war /usr/local/tomcat/webapps/web.war
#COPY /webapps/web.war /usr/local/tomcat/webapps
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
