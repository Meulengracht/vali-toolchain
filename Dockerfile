# Initial stage is to setup the cross compiler
# Label the image for cleaning after build process
FROM ubuntu as intermediate
LABEL stage=intermediate

ARG CROSS_PATH=/usr/workspace/toolchain-out

# Create the workspace
WORKDIR /usr/workspace/

ENV CROSS=$CROSS_PATH

# Install git to clone the toolchain
RUN apt-get update && apt-get install git
RUN git clone https://github.com/meulengracht/vali-toolchain && cd vali-toolchain
RUN mkdir -p $CROSS_PATH && .\depends.sh && .\checkout.sh && .\build-cross.sh

# 
FROM ubuntu

# Set the directory
WORKDIR /usr/workspace/

# copy all the files to the container
COPY mkdir -p $CROSS_PATH
COPY --from=intermediate $CROSS_PATH $CROSS_PATH
