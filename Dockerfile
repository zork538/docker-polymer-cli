###################################################################################
# Dockerfile to build a Polymer Dev Environment container images with Polymer-CLI
# for Raspberry PI
# Based on hypriot/rpi-node:6-slim and jefferyb/docker-polymer-cli
#  
# To build, do:
#   $ docker build -t jefferyb/polymer-cli .
#
###################################################################################

# Set the base image to node:4-slim
FROM hypriot/rpi-node:6-slim

MAINTAINER Elmar Wachtmeester <elmar@wachtmeestertjes.nl>

ENV POLYMER_CLI_HOME /home/polymer
ARG user=polymer
ARG group=polymer

RUN useradd -d "$POLYMER_CLI_HOME" -U -m -s /bin/bash ${user}

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    apt-get clean && \
    npm install -g gulp bower polymer-cli generator-polymer-init-custom-build

USER ${user}

EXPOSE 8080

RUN mkdir -p /home/${user}/app

VOLUME /home/${user}/app

WORKDIR /home/${user}/app

CMD bash
