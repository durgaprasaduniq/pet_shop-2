FROM amazonlinux:2023

# Install required packages
RUN yum update -y && \
    yum install -y git maven java-17-openjdk wget tar zip && \
    yum clean all

# Set JAVA_HOME (VERY IMPORTANT)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /opt

# Clone your repo
RUN git clone https://github.com/durgaprasaduniq/pet_shop-2.git

# Build WAR file
WORKDIR /opt/pet_shop-2
RUN mvn clean package -DskipTests

# Download and setup Tomcat
WORKDIR /opt
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz && \
    tar -xzf apache-tomcat-9.0.89.tar.gz && \
    mv apache-tomcat-9.0.89 tomcat

# Copy WAR to Tomcat
RUN cp /opt/pet_shop-2/target/*.war /opt/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
