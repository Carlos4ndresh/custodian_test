# FROM python:3.7-alpine
FROM alpine:latest


ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-custodian}
ENV SERVICE_HOME ${SERVICE_HOME:-/${SERVICE_USER}}


# I install python3, awscli, and terraform, from here the terraform stack services (s3,IAm role, etc) will be created
## as support for cloudcustodian.
### After that the output of the terraform creation will be used to store c7n logs 
# TODO pass AWSKEYS to container to allow terraform execution and cloudcustodian connection

RUN apk add --no-cache git python3 terraform &&\
  adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
  pip3 install virtualenv && pip3 install awscli && \
  virtualenv --python=python3 custodian && \
  . custodian/bin/activate && \
  pip3 install c7n

ENV PATH "/${SERVICE_USER}/bin:${PATH}"

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

COPY ./policies .

ENTRYPOINT 	[ "custodian" ]
CMD 		[ "--help" ]