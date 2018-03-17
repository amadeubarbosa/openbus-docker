# Why this? 

A Docker approach to quickly run OpenBus Services (http://www.tecgraf.puc-rio.br/openbus) from Tecgraf/PUC-Rio.

# Requirements

* Docker 1.9+ and some basic knowledge of it
* Internet connection

# Keep in mind:

* This a very short documentation to remember the basic usage of [Docker.](https://www.docker.com/)
* Our purpose here is solely to quick start a OpenBus service for development and testing. Never use this setup in production.
* OpenBus is an Open Source software check the [license.](https://jira.tecgraf.puc-rio.br/confluence/x/u5TWAg)
* If you don't want to build locally there are pre-built images at [docker.io.](https://hub.docker.com/r/amtera/openbus)
* You're free to modify this Docker recipe to meet your requirements

# How it works?

Docker will download the OpenBus binaries from the internet and build the image locally on your machine. 
Look into the Dockfile to understand the chosen platform and which OpenBus version will be executed. 

# Building the image

    docker build -t openbus .
    
# Running the core services

This will start the openbus service immediately. Use CTRL-c to terminate.

     docker run --rm -it --name=openbus -h openbus openbus:latest

# How to login into the machine

You can override the default behavior of starting the services with the following command.

    docker run --rm -it --name=openbus --entrypoint=/bin/bash openbus:latest

After login in you also can start the core services with the **bin/businit** script located at **/openbus**.

# How to execute extra services

[Collaboration and BusExtension services](https://jira.tecgraf.puc-rio.br/confluence/x/Q4EHB) are also installed and pre-configured on this image.

After login in you can start the extra services overiding NAME variable of **bin/businit** to identify the proper configuration, for example:

		NAME=collaboration bin/businit start
		NAME=governance bin/businit start

Both commands depends on **config** and **data** directories located at **/openbus** on docker image.

# Network ports used in the services

* OpenBus Core *2089*
* OpenBus Collaboration Service *2090*
* OpenBus Governance Extension Service *2091*
