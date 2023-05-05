FROM mysql:8.0.33-oracle

ADD --chmod=555 replica_node/files/setup.sh /docker-entrypoint-initdb.d/
COPY replica_node/files/docker-entrypoint.sh /usr/local/bin

RUN sed -i /etc/my.cnf -e '/skip-host-cache/d'

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]