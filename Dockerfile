# Initial stage is to setup the cross compiler
# Label the image for cleaning after build process
FROM ubuntu:latest as intermediate
LABEL stage=intermediate

ARG CROSS_PATH=/usr/workspace/toolchain-out

# Create the workspace
WORKDIR /usr/workspace/

ENV CROSS=$CROSS_PATH
ENV DEBIAN_FRONTEND=noninteractive 

# Install git to clone the toolchain
RUN apt-get update && apt-get -qq install git cmake libelf1 libffi7 libelf-dev libffi-dev make gcc g++ git flex bison python libyaml-dev
RUN git clone https://github.com/meulengracht/vali-toolchain
RUN mkdir -p $CROSS_PATH && cd vali-toolchain && python get-pip.py && \
    pip install prettytable Mako pyaml dateutils --upgrade && \
    ./checkout.sh && ./build-cross.sh

# 
FROM ubuntu

# Set the directory
WORKDIR /usr/workspace/

# copy all the files to the container
COPY mkdir -p $CROSS_PATH
COPY --from=intermediate $CROSS_PATH $CROSS_PATH
