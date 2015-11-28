FROM ubuntu:14.04
MAINTAINER Amtera Semantic Techologies <contact@amtera.com.br>

ENV OPENBUS_HOME /openbus
ENV PATH="$OPENBUS_HOME/bin:$PATH"
ENV BUSDISTFILE openbus-core-2.0.0.8-Linux26g4_64.tar.gz
ENV BUSDISTURL https://jira.tecgraf.puc-rio.br/confluence/download/attachments/47617769/$BUSDISTFILE

RUN apt-get update && apt-get install -y wget
RUN mkdir $OPENBUS_HOME
WORKDIR $OPENBUS_HOME

RUN wget -O $BUSDISTFILE $BUSDISTURL
RUN tar xf $BUSDISTFILE
ADD *.lua *.crt *.key startbus ./
RUN chmod +x startbus

ENTRYPOINT busservices -privatekey openbus.key -admin admin -validator validator





# busadmin --login=admin --password=admin --script=sbepuser.lua


