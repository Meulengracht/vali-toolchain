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

# Install the required packages needed to build the toolchain
RUN env | sort > env.intermediate
RUN mkdir -p $CROSS_PATH
RUN apt-get update && apt-get -y -qq install git cmake libelf1 libffi7 libelf-dev libffi-dev make gcc g++ git flex bison python libyaml-dev
RUN python get-pip.py && pip install prettytable Mako pyaml dateutils --upgrade
RUN sed -i 's/\r$//' ./checkout.sh && chmod +x ./checkout.sh && ./checkout.sh
RUN mkdir -p output && cd output && \
    cmake -G "Unix Makefiles" -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=True -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld' -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_TESTS=Off -DLLVM_INCLUDE_EXAMPLES=Off -DCMAKE_INSTALL_PREFIX=$CROSS_PATH -DLLVM_DEFAULT_TARGET_TRIPLE=amd64-uml-vali ../sources/llvm-project/llvm
RUN cd output && make -j2 && make install

# Now we setup the environment for using the cross-compiler
FROM ubuntu:latest

# Import arg from previous stage
ARG CROSS_PATH=/usr/workspace/toolchain-out

# Setup environmental variables
ENV CROSS=$CROSS_PATH

# Set the directory
WORKDIR /usr/workspace/

# Configure apt and install only basic required packages
RUN apt-get update \
    #
    # Install vali dependencies for development
    && mkdir -p $CROSS_PATH \
    && apt-get -y install git \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# copy all the files to the container
COPY --from=intermediate /usr/workspace/toolchain/env.intermediate .
COPY --from=intermediate $CROSS_PATH $CROSS_PATH

# Start the bash command line
CMD ["/bin/bash"]
