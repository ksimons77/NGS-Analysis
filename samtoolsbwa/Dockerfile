# http://www.htslib.org/

# Install steps based on https://github.com/samtools/samtools/blob/develop/INSTALL

FROM debian:jessie

# Install dependencies

RUN apt-get update \

    && apt-get install -y --no-install-recommends \

        bzip2 \
        ca-certificates \
        curl \
        gcc \
        libbz2-dev \
        libcurl4-openssl-dev \
        libc6-dev \
        liblzma-dev \
        libncurses5-dev \
        make \
        zlib1g-dev \
        parallel \

    && rm -rf /var/lib/apt/lists/*

# Install samtools

ENV SAMTOOLS_VERSION 1.4

RUN curl -SL https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 --output samtools.tar.bz2 \

    && tar -xjf samtools.tar.bz2 \
    && rm samtools.tar.bz2 \
    && cd samtools-$SAMTOOLS_VERSION \
    && ./configure --enable-plugins --enable-libcurl --with-plugin-path=samtools-$SAMTOOLS_VERSION/htslib-1.4 \
    && make all plugins-htslib \
    && make install

# http://bio-bwa.sourceforge.net/

# Install bwa

ENV BWA_VERSION 0.7.15

RUN curl -SL https://sourceforge.net/projects/bio-bwa/files/bwa-$BWA_VERSION.tar.bz2/download --output bwa.tar.bz2 \

    && tar -xjf bwa.tar.bz2 \
    && rm bwa.tar.bz2 \
    && cd bwa-$BWA_VERSION \
    && make \
    && cd .. \
    && ln -s /bwa-$BWA_VERSION/bwa /usr/bin/bwa

ENTRYPOINT ["bwa"]
