FROM ubuntu:22.04

ARG arg1=hello
ARG arg2=world

RUN apt-get update && \
    apt-get install curl -y 

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash && \ 
    apt-get install -y nodejs



RUN apt-get install build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev -y

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install yarn


COPY /ens-metadata-service /ens-metadata-service

WORKDIR /ens-metadata-service


RUN cp .env.org .env  && \
    yarn && \
    yarn build
   
RUN echo  $arg1 $arg2

ENTRYPOINT [ "yarn", "start" ]
