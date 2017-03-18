FROM buildpack-deps:jessie

# Install samtools
ENV SAMTOOLS_VERSION 1.4
RUN curl -SL https://github.com/samtools/samtools/releases/download/$SAMTOOLS_VERSION/samtools-$SAMTOOLS_VERSION.tar.bz2 --output samtools.tar.bz2 \
    && tar -xjf samtools.tar.bz2 \
    && rm samtools.tar.bz2 \
    && cd samtools-$SAMTOOLS_VERSION \
    && ./configure --enable-plugins --enable-libcurl --with-plugin-path=samtools-$SAMTOOLS_VERSION/htslib-1.4 \
    && make all plugins-htslib \
    && ln -s /samtools-$SAMTOOLS_VERSION/samtools /usr/bin/samtools
    
ENTRYPOINT ["samtools"]
