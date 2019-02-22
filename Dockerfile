FROM python:3.7-slim-stretch

ENV ECCODES_VERSION 2.12.0

RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get -y -t stretch-backports install libaec-dev libsz2 \
    && apt-get install -y libhdf5-dev linux-libc-dev zlib1g-dev libc-dev-bin libc6-dev libjpeg-dev libjpeg62-turbo libjpeg62-turbo-dev libbsd-dev libgomp1 libquadmath0 gcc wget cmake git \
    && pip install cython \
    && pip install numpy \
    && cd /tmp \
    && wget http://shdh.ca/eccodes-2.12.0-Source.tar.gz \
    && tar xvzf eccodes-${ECCODES_VERSION}-Source.tar.gz \
    && rm -f eccodes-${ECCODES_VERSION}-Source.tar.gz \
    && mkdir /tmp/build \
    && cd /tmp/build \
    && cmake -DENABLE_FORTRAN=OFF -DENABLE_PNG=OFF /tmp/eccodes-${ECCODES_VERSION}-Source \
    && make \
    && make install \
    && cd /tmp/build/python3 \
    && python setup.py install \
&& rm -rf /tmp/* && apt-get remove -y libaec-dev libhdf5-dev linux-libc-dev zlib1g-dev libc-dev-bin libc6-dev libjpeg-dev libjpeg62-turbo-dev libbsd-dev wget cmake gcc git \
&& apt-get clean
