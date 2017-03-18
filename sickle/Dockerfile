# https://github.com/najoshi/sickle

FROM buildpack-deps:jessie

# Install sickle
RUN git clone https://github.com/najoshi/sickle.git \
    && cd sickle \
    && make \
    && ln -s /sickle/sickle /usr/bin/sickle
    
ENTRYPOINT ["sickle"]
