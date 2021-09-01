# M21CS001 - Docker File for Angular Web Service

A sample angular web application with a dockerfile for environment portability

The reposiroty contains the sample Angular Web Application (default web application that comes with the Angular package) and a dockerfile has been written so that the project can be seamlessly moved across systems.

The web application displays the various functionalities that an Angular Web Application can provide.

The docker file was written from scratch and no existing server or docker image was used to write this dockerfile.

To get started, it is mandatory to install docker in the user's system. To do the same, please follow the following link - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

The instructions in the dockerfile contain a step by step container building guide so that docker can build a container and generate an image which can be migrated across platforms.

## List of terminal commands used:

    FROM ubuntu:20.01

This is used to specify that Ubuntu 20.04 will be used as the underlying operating system architecture to build the docker image.

    RUN rm /bin/sh && ln -s /bin/bash /bin/sh

    RUN apt-get update; apt-get install curl -y && apt-get -y autoclean && apt-get -y install sudo
    
    RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
    
    RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
    
    RUN source ~/.bashrc

The above instructions install a few basic package instructions that are necessary for installing Angular on the Ubunutu system. They also give root access to the instructions being executed, so that the 'sudo' command need not be used.

    ENV NVM_DIR /root/.nvm
    ENV NODE_VERSION 16.8.0
    
    RUN source $NVM_DIR/nvm.sh \
        && nvm install $NODE_VERSION \
        && nvm alias default $NODE_VERSION \
        && nvm use default
    
    ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
    ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

The above set of instructions install nvm i.e. the Node version manager and the path of the same is set to enviroment variables.

    RUN npm install npm@7.21.1 -g

The above instruction installs the Node Package Manager in the Ubuntu system architecture.

    RUN npm install -g @angular/cli@12.2 --unsafe-perm=true --allow-root
This instruction installs the Angular Web Service packages onto the Ubuntu image OS architecture.

    RUN ng new web-application-project

    RUN cd web-application-project

This instruction generates a new angular project with the necessary build files as well as source code files, which the developer will be able to modify.

    RUN ng serve

This instruction hosts the web application on a localhost.

## Building a docker image with this dockerfile

To build a docker image with the dockerfile, use the command

    docker build -t < *insert-image-name* >/angular-app

This command builds the docker image by sequentially executing instructions in the dockerfile. It may take up to 5 minutes for the image to successfully get built.

To check if your image has been successfully built, use the command

    docker images

And check if the image that you just built appears in the list.

To run the docker container, use the below commands

    `docker run -d -it -p 80:80/tcp --name angular-app`<*insert-image-name*>:latest`

 Now, open your browser and key in 

    URL HTTP://<docker machine URL>:80
Thus, the Angular Web Application has been successfully dockerised and hosed in a docker container.
