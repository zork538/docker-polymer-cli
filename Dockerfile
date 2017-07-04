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
    apt-get clean

RUN npm install -g gulp bower
RUN npm install -g polymer-cli@0.17.0

USER polymer

EXPOSE 8080

RUN mkdir -p /home/polymer/workspace

VOLUME /home/polymer/workspace

WORKDIR /home/polymer/workspace

CMD bash
