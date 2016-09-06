FROM postgres:latest

VOLUME /data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["pg_dumpall"]
