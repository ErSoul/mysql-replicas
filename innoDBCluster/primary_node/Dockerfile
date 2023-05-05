FROM mysql:8.0.33-oracle

COPY primary_node/files/docker-entrypoint.sh /usr/local/bin
ADD --chmod=644 primary_node/files/01-replication.conf /etc/my.cnf.d/
ADD --chmod=555 primary_node/files/setup.sh /docker-entrypoint-initdb.d/

RUN sed -i /etc/my.cnf -e '/\[mysqld\]/r /etc/my.cnf.d/01-replication.conf' -e '/skip-host-cache/d'