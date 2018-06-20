FROM ubuntu:18.04
MAINTAINER Nikolas Garofil "nikolas@garofil.be"
RUN apt-get update && apt-get -y install git make default-d-compiler gcc libcurl4-openssl-dev libsqlite3-dev && apt-get --purge autoremove && rm -r /var/cache/apt/archives
#TODO -b bezig later afvoeren
RUN git clone --single-branch -b bezig https://github.com/ngaro/onedrive.git && mv onedrive onedrive_code
WORKDIR onedrive_code
RUN make DC=ldmd2
