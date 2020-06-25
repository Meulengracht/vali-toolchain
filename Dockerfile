# Initial stage is to setup the cross compiler
# Label the image for cleaning after build process
FROM ubuntu:latest as intermediate
LABEL stage=intermediate

ARG CROSS_PATH=/usr/workspace/toolchain-out

# Create the workspace
WORKDIR /usr/workspace/toolchain

ENV DEBIAN_FRONTEND=noninteractive 

# Copy the shell scripts to container
COPY . .

# Install git to clone the toolchain
RUN mkdir -p $CROSS_PATH
RUN apt-get update && apt-get -y -qq install git cmake libelf1 libffi7 libelf-dev libffi-dev make gcc g++ git flex bison python libyaml-dev
RUN python get-pip.py && pip install prettytable Mako pyaml dateutils --upgrade
RUN ./checkout.sh
RUN mkdir -p output && cd output && \
    cmake -G "Unix Makefiles" -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=True -DLLVM_ENABLE_EH=True -DLLVM_ENABLE_RTTI=True -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=Off -DLLVM_INCLUDE_EXAMPLES=Off -DCMAKE_INSTALL_PREFIX=$CROSS_PATH -DLLVM_DEFAULT_TARGET_TRIPLE=i386-pc-win32-itanium-coff ../sources/llvm
RUN cd output && make && make install

# 
FROM ubuntu:latest

# Set the directory
WORKDIR /usr/workspace/

# copy all the files to the container
COPY mkdir -p $CROSS_PATH
COPY --from=intermediate $CROSS_PATH $CROSS_PATH
