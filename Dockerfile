FROM ubuntu:14.04
MAINTAINER Amtera Semantic Techologies <contact@amtera.com.br>

ENV OPENBUS_HOME /openbus
ENV PATH="$OPENBUS_HOME/bin:$PATH"
ENV BUSDISTFILE openbus-core-2.1.0.2-Linux26g4_64.tar.gz
ENV EXTDISTFILE openbus-busextension-1.0.1-Linux26g4_64.tar.gz
ENV COLABDISTFILE openbus-collab-1.1.0.1-Linux26g4_64.tar.gz

ENV BUSDISTURL https://jira.tecgraf.puc-rio.br/confluence/download/attachments/67600694/$BUSDISTFILE
ENV EXTDISTURL https://jira.tecgraf.puc-rio.br/confluence/download/attachments/67600707/$EXTDISTFILE
ENV COLABURL https://jira.tecgraf.puc-rio.br/confluence/download/attachments/52528884/$COLABDISTFILE

RUN apt-get update && apt-get install -y wget
RUN mkdir $OPENBUS_HOME
WORKDIR $OPENBUS_HOME

RUN wget -O $BUSDISTFILE $BUSDISTURL
RUN wget -O $EXTDISTFILE $EXTDISTURL
RUN wget -O $COLABDISTFILE $COLABURL

RUN tar xf $BUSDISTFILE
RUN tar xf $EXTDISTFILE
RUN tar xf $COLABDISTFILE

RUN mkdir security

ADD security/* security/
ADD config/* config/

ADD *.lua ./

VOLUME /openbus/data

RUN bin/businit start \
 && bin/busadmin -busref localhost:2089 -entity admin -password admin -domain "" bin/busadmdesc.lua config/collaboration.adm \
 && bin/busadmin -busref localhost:2089 -entity admin -password admin -domain "" bin/busadmdesc.lua config/governance.adm \
 && NAME=collaboration bin/businit start \
 && NAME=governance bin/businit start || tail -n 100 data/openbus.log data/collaboration.log data/governance.log

ENTRYPOINT /openbus/bin/businit start && tail -f /openbus/data/openbus.log
