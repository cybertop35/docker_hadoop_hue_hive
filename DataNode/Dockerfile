#Download base image
FROM ubuntu:19.04

USER root
 
RUN hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME 

# Hdfs ports
EXPOSE 8020 9870
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports

ADD dataNodeRun.sh /opt/bin/entrypoint.sh
RUN chmod a+x /opt/bin/entrypoint.sh

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
