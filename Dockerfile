FROM quay.io/wuvt/docker-postgres:latest

RUN apt-get update && apt-get install -y curl openssh-client

VOLUME /data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["autodump"]
