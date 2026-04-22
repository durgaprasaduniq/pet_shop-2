# -------- Stage 1: Build --------
FROM amazonlinux:2023 AS build

# Install build tools
RUN dnf update -y && \
    dnf install -y git maven java-17-amazon-corretto && \
    dnf clean all

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH=$JAVA_HOME/bin:$PATH

WORKDIR /app

# Clone your repo
RUN git clone https://github.com/durgaprasaduniq/pet_shop-2.git

# Build WAR file
WORKDIR /app/pet_shop-2
RUN mvn clean package -DskipTests


# -------- Stage 2: Runtime --------
FROM amazonlinux:2023

# Install only runtime dependencies (NO maven)
RUN dnf update -y && \
    dnf install -y java-17-amazon-corretto wget tar && \
    dnf clean all

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH=$JAVA_HOME/bin:$PATH

WORKDIR /opt

# Install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-11/v11.0.0/bin/apache-tomcat-11.0.0.tar.gz && \
    tar -xzf apache-tomcat-11.0.0.tar.gz && \
    mv apache-tomcat-11.0.0 tomcat

# Copy WAR from build stage
COPY --from=build /app/pet_shop-2/target/*.war /opt/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]"run"]
