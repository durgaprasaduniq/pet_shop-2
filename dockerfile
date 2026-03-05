FROM amazonlinux
RUN yum upgrade && yum install git -y && yum install maven -y wget tar zip
WORKDIR /opt
RUN git clone https://github.com/durgaprasaduniq/pet_shop-2.git
RUN cd pet_shop-2 && mvn clean package
WORKDIR /opt
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.115/bin/apache-tomcat-9.0.115.tar.gz 
RUN tar -xvzf apache-tomcat-9.0.115.tar.gz
RUN mv apache-tomcat-9.0.115 tomcat
RUN cp pet_shop-2/target/*.war /opt/tomcat/webapps
CMD ["/opt/tomcat/bin/catalina.sh","run"]
EXPOSE 8080
