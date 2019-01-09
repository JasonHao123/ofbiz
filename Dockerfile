from  openjdk:8-jdk

RUN apt-get update

RUN mkdir /apache-ofbiz-16.11.05

COPY framework

workdir  apache-ofbiz-16.11.05
run  ./gradlew clean -x test


EXPOSE 8443/tcp

COPY entityengine.xml /apache-ofbiz-16.11.05/framework/entity/config/entityengine.xml
COPY mysql.sql /
COPY postgresql.sql /
COPY test.sh /
RUN chmod +x /test.sh
COPY pgpass /root/.pgpass
RUN chmod 0600 /root/.pgpass

cmd  ./gradlew ofbiz  -x test
