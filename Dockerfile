####
# This Dockerfile is used in order to build a container that runs the Quarkus application in JVM mode
#
# Before building the docker image run:
#
# mvn package
#
# Then, build the image with:
#
# docker build -f src/main/docker/Dockerfile.jvm -t quarkus/rest-json-jvm .
#
# Then run the container using:
#
# docker run -i --rm -p 8080:8080 quarkus/rest-json-jvm
#
###
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.6
ARG JAVA_PACKAGE=java-11-openjdk-headless-11.0.20.0.8-3.el8.x86_64
ARG RUN_JAVA_VERSION=1.3.8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' \
    HOME=/deployments
# Install java and the run-java script
# Also set up permissions for user `1001`
RUN microdnf install openssl curl ca-certificates ${JAVA_PACKAGE} 
RUN microdnf update 
RUN microdnf clean all \
    && mkdir /deployments \
    && chmod ug+rwX /deployments \
    && curl https://repo1.maven.org/maven2/io/fabric8/run-java-sh/${RUN_JAVA_VERSION}/run-java-sh-${RUN_JAVA_VERSION}-sh.sh -o /deployments/run-java.sh \
    && chown 1001:root -Rf /deployments/ \
    && chmod ug+rx /deployments/run-java.sh \
    && echo "securerandom.source=file:/dev/urandom" >> /etc/alternatives/jre/lib/security/java.security
# Configure the JAVA_OPTIONS, you can add -XshowSettings:vm to also display the heap size.
ENV JAVA_OPTIONS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"

RUN microdnf install shadow-utils \ 
    && useradd -u 1001 -r -g 0 -d /deployments -s /sbin/nologin -c "Default Application User" java-run \
    && microdnf remove shadow-utils \
    && microdnf clean all
WORKDIR /deployments
USER 1001
ENTRYPOINT [ "/deployments/run-java.sh" ]
