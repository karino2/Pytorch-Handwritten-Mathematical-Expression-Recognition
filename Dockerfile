FROM ubuntu:16.04

## based on https://hub.docker.com/r/mapler/pytorch-cpu/dockerfile, but modify a little.

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install conda-build && \
     /opt/conda/bin/conda create -y --name pytorch-py35 python=3.5.2 numpy pyyaml scipy ipython mkl jupyter pandas && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/envs/pytorch-py35/bin:$PATH
RUN conda install --name pytorch-py35 pytorch-cpu=0.4.0 torchvision -c pytorch && /opt/conda/bin/conda clean -ya

WORKDIR /work
ENTRYPOINT ["/bin/bash"]