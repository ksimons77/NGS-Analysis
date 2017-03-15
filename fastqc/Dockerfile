FROM java:8u111-jre

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        perl \
    && rm -rf /var/lib/apt/lists/*

ENV FASTQC_VERSION v0.11.5

RUN curl -SL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_$FASTQC_VERSION.zip --output fastqc.zip \
    && unzip fastqc.zip \
    && chmod 755 /FastQC/fastqc
    && rm fastqc.zip

ENTRYPOINT FastQC/fastqc
