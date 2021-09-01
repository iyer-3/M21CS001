FROM ubuntu:20.04

SHELL ["bash", "-lc"]

CMD ["node", "server.js"] 

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update; apt-get install curl -y && apt-get -y autoclean && apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

RUN source ~/.bashrc

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 16.8.0

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install npm@7.21.1 -g

RUN apt-get install nodejs -y 

RUN npm uninstall -g @angular/cli

RUN npm cache clean --force

RUN NPM_CONFIG_PREFIX=~/.npm-global

RUN source ~/.profile

RUN npm install -g jshint

RUN npm install -g @angular/cli@12.2 --unsafe-perm=true --allow-root

RUN ng new web-application-project

RUN cd web-application-project

RUN ng serve