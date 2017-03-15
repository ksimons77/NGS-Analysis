FROM java:8u111-jre

ENV FASTQC_VERSION v0.11.5

RUN curl -SL http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_$FASTQC_VERSION.zip --output fastqc.zip \
    && unzip fastqc.zip \
    && rm fastqc.zip
