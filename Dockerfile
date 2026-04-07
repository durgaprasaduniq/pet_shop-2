# ---------- Stage 1: ---------
FROM maven:3.9.9-amazoncorretto-17 AS builder

WORKDIR /build

RUN yum install git -y 

RUN git clone https://github.com/durgaprasaduniq/pet_shop-2.git

WORKDIR /build/pet_shop-2

RUN mvn clean package 


# ---------- Stage 2: ----------
FROM amazonlinux
RUN yum update -y && \
    yum install -y git wget tar && \
    yum clean all

WORKDIR /opt

RUN wget https://archive.apache.org/dist/tomcat/tomcat-11/v11.0.0/bin/apache-tomcat-11.0.0.tar.gz && \
    tar -xzf apache-tomcat-11.0.0.tar.gz && \
    mv apache-tomcat-11.0.0 tomcat

COPY --from=builder /build/pet_shop-2/target/*.war /opt/tomcat/webapps
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
