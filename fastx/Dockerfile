# http://hannonlab.cshl.edu/fastx_toolkit/index.html
# Install steps based on http://hannonlab.cshl.edu/fastx_toolkit/install_ubuntu.txt

#FROM buildpack-deps:jessie

FROM debian:jessie

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    autoconf \
        bzip2 \
        ca-certificates \
        curl \
        g++ \
        gcc \
        libc6-dev \
        make \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install libgtextutils
ENV LIBGTEXTUTILS_VERSION 0.6.1
RUN curl -SL http://hannonlab.cshl.edu/fastx_toolkit/libgtextutils-$LIBGTEXTUTILS_VERSION.tar.bz2 --output libgtextutils.tar.bz2 \
    && tar -xjf libgtextutils.tar.bz2 \
    && rm libgtextutils.tar.bz2 \
    && cd /libgtextutils-$LIBGTEXTUTILS_VERSION \
    && ./configure \
    && make \
    && make install \
    && cd /

# Install fastx
ENV FASTX_VERSION 0.0.14
RUN curl -SL https://github.com/agordon/fastx_toolkit/releases/download/$FASTX_VERSION/fastx_toolkit-$FASTX_VERSION.tar.bz2 --output fastx_toolkit.tar.bz2 \
    && tar -xjf fastx_toolkit.tar.bz2 \
    && rm fastx_toolkit.tar.bz2 \
    && cd /fastx_toolkit-$FASTX_VERSION \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && ldconfig

ENTRYPOINT ["fastx_uncollapser"]
