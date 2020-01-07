from ubuntu:latest

run apt-get update  

#install and clone from git
run apt-get install -y git
run git clone https://github.com/shiva-priya/TaskWebApp.git

#install jdk
run apt-get -y update && apt-get -y upgrade
run apt-get -y install openjdk-8-jdk wget

#build java project with mvn wrapper
WORKDIR TaskWebApp/IdeaProjects/task-web
run ./mvnw clean install

#install tomcat
run groupadd tomcat
run useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
run mkdir /usr/local/tomcat

#tomcat tar and extract 
run cd /opt/
run wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.34.tar.gz  -O /tmp/tomcat.tar.gz
run cd /tmp && tar xvfz tomcat.tar.gz
run cp -Rv /tmp/apache-tomcat-8.5.34/* /usr/local/tomcat/

#copy war from target to webapps
run pwd
#COPY tomcat-users.xml ../../../usr/local/tomcat/conf/tomcat-users.xml
run cp target/servlet.war ../../../usr/local/tomcat/webapps

#expose port and start tomcat
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
