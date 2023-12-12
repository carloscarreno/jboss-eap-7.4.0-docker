FROM jboss/base-jdk:11

ENV JBOSS_VERSION jboss-eap-7.4.0
ENV RH_HOME /opt/rh
ENV EAP_HOME $RH_HOME/jboss-eap-7.4

COPY $JBOSS_VERSION.zip /tmp/ 

USER root

RUN yum install -y unzip \
    && unzip /tmp/$JBOSS_VERSION.zip -d $RH_HOME \
    && export EAP_HOME=$EAP_HOME \
    && $EAP_HOME/bin/add-user.sh admin JBoss#1! --silent

EXPOSE 8080 9990 

WORKDIR $EAP_HOME/bin
ENTRYPOINT ["./standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
