FROM alpine:latest
MAINTAINER "L0gIn <imladjenovic@scottlogic.com>"

ENV TERRAFORM_VERSION=0.12.21

RUN apk add musl-dev

RUN apk add python2-dev  # for python2.x installs
RUN apk add python3-dev  # for python3.x installs

RUN apk add libffi-dev
RUN apk add  openssl-dev

RUN apk add --no-cache gcc 

# aws cli and other bash tools
RUN apk -v --update add \
        zip \
        git \
        bash \
        wget \
        jq \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        openssh-client \
        && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools distribute awscli s3cmd awsebcli python-magic && \
    rm /var/cache/apk/*

# terraform
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN cat terraform_${TERRAFORM_VERSION}_SHA256SUMS | grep terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_SHA256SUMS
RUN sha256sum -cs terraform_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# node and npm
RUN apk add --update nodejs npm
