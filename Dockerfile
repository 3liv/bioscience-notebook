# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ali Versi <aliversi@gmail.com>"

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    libudunits2-dev \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID
ENV TAR="/bin/tar"

RUN conda config --add channels r && \
    conda config --add channels bioconda 

RUN conda install --quiet --yes \  
    'numpy=1.15*' \
    'matplotlib=*' \
    'pandas=*' \
    'seaborn=*' \
    'scipy=*' \
    'xlrd=*'\
    'curl=*' \
    'biom-format=*' \ 
    'bioconductor-biocinstaller=*' \
    'bioconductor-microbiome=*' \
    'bioconductor-deseq2=*'

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
    'r-wgcna=*' \
    'r-sp=*' \
    'r-spdep=*' \
    'rpy2==*' 


RUN pip install simplegeneric numpy pandas scipy matplotlib seaborn scikit-bio xlrd tableone
    
RUN conda clean -tipsy && \
    fix-permissions $CONDA_DIR


RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/adegraphics_1.0-15.tar.gz', repos = NULL, method = 'libcurl')"
RUN Rscript -e "install.packages('adespatial', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "library(devtools); install_github('umerijaz/microbiomeSeq')"

