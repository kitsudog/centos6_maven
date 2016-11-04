FROM kitsudo/centos6_jdk8
MAINTAINER Dave Luo <kitsudo163@163.com>

ENV MAVEN_VERSION=3.3.9
ENV MAVEN_HOME=/opt/maven

RUN yum install -y \
        wget

RUN wget --no-check-certificate --no-cookies http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && wget --no-check-certificate --no-cookies http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5 \
    && echo "$(cat apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5) apache-maven-${MAVEN_VERSION}-bin.tar.gz" | md5sum -c \
    && tar -zvxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt/ \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/mvn \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5

RUN mkdir ~/.m2 && echo '\
<?xml version="1.0" encoding="UTF-8"?>\
<settings>\
  <mirrors>\
    <mirror>\
      <id>alimaven</id>\
      <name>aliyun maven</name>\
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>\
      <mirrorOf>central</mirrorOf>\
    </mirror>\
  </mirrors>\
</settings>\
' > ~/.m2/setting.xml

