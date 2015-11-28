# Why this? 

A Docker approach to quickly run Openbus Services from Tecgraf/PUC-Rio or if you are a more Do It Yourself Style 
follow the documentation [here.](https://jira.tecgraf.puc-rio.br/confluence/x/s5TWAg)

# Requirements

* Docker 1.9+ and some basic knowledge of it
* Internet connection

# Keep in mind:

* This a very short documentation to remember the basic usage of [Docker.](https://www.docker.com/)
* Our purpose here is solely to quick start a Openbus service for development and testing. Never use this setup in production.
* Openbus is an Open Source software check the [license.](https://jira.tecgraf.puc-rio.br/confluence/x/u5TWAg)
* You're free to modify this Docker recipe to meet your requirements

# How it works?

Docker will download the Openbus binaries from the internet and build the image locally on your machine. 
Look into the Dockfile to understand the chosen platform and which Openbus version will be executed. 

# Building the image

    docker build -t openbus-core-linux26g4 .
    
# Running the core services

This will start the openbus service immediately. Use CTRL-c to terminate.

     docker run --rm -it --name=openbus -h openbus openbus-core-linux26g4:latest

# How to login into the machine

You can override the default behavior of starting the services with the following command.

    docker run --rm -it --name=openbus --entrypoint=/bin/bash openbus-core-linux26g4:latest

After login in you also can start the services with the 
```
#!bash

startbus
```
 script located at /openbus.