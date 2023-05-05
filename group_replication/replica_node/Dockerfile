FROM mysql:8.0.33-oracle

ADD --chown=mysql:mysql --chmod=444 replica_node/files/01-replication.conf /etc/my.cnf.d/
ADD --chown=mysql:mysql --chmod=444 replica_node/files/public_key.pem /etc/my.cnf.d/primary-node-public-key.pem
ADD --chmod=555 replica_node/files/startup.sh /docker-entrypoint-initdb.d/
ADD --chown=mysql:mysql --chmod=755 replica_node/files/02-run_once.sh /db_scripts/
ADD --chown=mysql:mysql --chmod=755 replica_node/files/01-replica_user.sh /db_scripts/

RUN sed -i /etc/my.cnf -e '/skip-host-cache/d' && chmod o+w /etc && chown mysql:mysql /etc/my.cnf