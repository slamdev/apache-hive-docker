ARG JDK_TAG=17.0.1_12-jdk-alpine

FROM eclipse-temurin:${JDK_TAG}

ARG HIVE_VERSION
ARG HADOOP_VERSION

ENV HIVE_HOME=/opt/hive
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=${HIVE_HOME}/bin:${HADOOP_HOME}/bin:${PATH}

WORKDIR /opt

RUN wget -q https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
 && tar -zxf apache-hive-${HIVE_VERSION}-bin.tar.gz && rm -f apache-hive-${HIVE_VERSION}-bin.tar.gz \
 && mv apache-hive-${HIVE_VERSION}-bin hive \
 && wget -q https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
 && tar -zxf hadoop-${HADOOP_VERSION}.tar.gz && rm -f hadoop-${HADOOP_VERSION}.tar.gz \
 && mv hadoop-${HADOOP_VERSION} hadoop \
 && rm -f hadoop/share/hadoop/common/lib/slf4j-log4j12-*.jar \
 && echo done

ENTRYPOINT ["hive"]
