FROM nrel/openstudio:3.3.0

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends \
        wget \ 
        build-essential \
        checkinstall \
        libreadline-gplv2-dev \
        libncursesw5-dev \
        libssl-dev \
        libsqlite3-dev \
        tk-dev \
        libgdbm-dev \
        libc6-dev \
        libbz2-dev \
        libffi-dev \
        zlib1g-dev \
    && apt clean -y all

RUN wget https://www.python.org/ftp/python/3.8.8/Python-3.8.8.tgz && \
    tar xzf Python-3.8.8.tgz && \
    cd Python-3.8.8 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm -rf Python-3.8.8 && \
    rm -rf Python-3.8.8.tgz

RUN sudo apt install -y -V ca-certificates lsb-release && \
    wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb && \
    sudo apt install -y -V ./apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb && \
    sudo sed -i 's/bintray\.com/jfrog.io\/artifactory/g' /etc/apt/sources.list.d/apache-arrow.sources && \
    sudo apt update && \
    sudo apt install -y -V libarrow-dev libarrow-glib-dev libarrow-dataset-dev libparquet-dev libparquet-glib-dev

COPY . /buildstock-batch/
RUN python3.8 -m pip install /buildstock-batch
