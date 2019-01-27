# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda config --add channels r && \
    conda config --add channels bioconda 

RUN conda install --quiet --yes \  
    'numpy==1.15*' \
    'matplotlib==*' \
    'pandas==*' \
    'xlrd==*' \
    'bioconductor-biocinstaller==*' \
    'bioconductor-microbiome==*'

# R packages
RUN conda install --quiet --yes  -c r \
    'r-base=3.5.*' \
    'r-irkernel=*' \
    'r-plyr=*' \
    'r-devtools=*' \
    'r-shiny=*' \
    'r-rmarkdown=*' \
    'r-forecast=*' \
    'r-rsqlite=*' \
    'r-reshape2=*' \
    'r-nycflights13=*' \
    'r-caret=*' \
    'r-rcurl=*' \
    'r-crayon=*' \
    'r-randomforest=*' \
    'r-htmltools=*' \
    'r-sparklyr=*' \
    'r-htmlwidgets=*' \
    'r-hexbin=*' \
    'rpy2==*' 


RUN pip install simplegeneric
    
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR

