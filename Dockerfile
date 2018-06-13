FROM ubuntu:18.04
MAINTAINER Nikolas Garofil "nikolas@garofil.be"
RUN apt-get update
RUN apt-get -y install git make default-d-compiler gcc libcurl4-openssl-dev libsqlite3-dev
RUN git clone https://github.com/ngaro/onedrive.git && mv onedrive onedrive_code
WORKDIR onedrive_code
RUN make DC=ldmd2
RUN ln -s /onedrive_code/onedrive /usr/local/bin/onedrive
