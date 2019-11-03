#Download base image
FROM ubuntu:19.04

USER root
# apt-get upgrade -y &&
RUN apt-get update && DEBIAN_FRONTEND=noninteractive  apt-get install -y openjdk-8-jdk net-tools openssh-server openssh-client curl && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Hadoop Configiration

# Scarico HADOOP
ENV HADOOP_VERSION 3.1.2
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN curl -fSL http://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz -o /tmp/hadoop.tar.gz \
	&& tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
	&& rm /tmp/hadoop.tar.gz*
	&& ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
	&& mkdir /opt/hadoop-$HADOOP_VERSION/logs  \
	&& mkdir -p /opt/data/hadoop/hadooptmpdata \
	&& mkdir -p /opt/data/hadoop/hdfs/namenode \
	&& mkdir -p /opt/data/hadoop/hdfs/datanode \
	&& ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
 	&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys\
 	&& chmod 0600 ~/.ssh/authorized_keys

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
ENV CLUSTER_NAME=TEST_CLUSTER

ADD core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
 
RUN hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME 

# Hdfs ports
EXPOSE 8020 9870
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports

ADD hadoopRun.sh /opt/bin/entrypoint.sh
RUN chmod a+x /opt/bin/entrypoint.sh

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
