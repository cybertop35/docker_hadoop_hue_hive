#!/bin/bash

export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"


etc/init.d/ssh start



echo $(hostname -f)
sed -i "s/HOSTNAME/$(hostname -f)/" $HADOOP_HOME/etc/hadoop/core-site.xml
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
#echo 'export HADOOP_SSH_OPTS="-p 22"' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh


start-dfs.sh
start-yarn.sh
#hdfs --config $HADOOP_CONF_DIR --hostnames "$(hostname -f)"  namenode
#hdfs --config $HADOOP_CONF_DIR datanode
#yarn --config $HADOOP_CONF_DIR nodemanager
tail -f /dev/null