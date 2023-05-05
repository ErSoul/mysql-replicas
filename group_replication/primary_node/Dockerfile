FROM mysql:8.0.33-oracle

ADD --chown=mysql:mysql --chmod=400 primary_node/files/private_key.pem /etc/my.cnf.d/
ADD --chown=mysql:mysql --chmod=444 primary_node/files/01-replication.conf /etc/my.cnf.d/

ADD --chown=mysql:mysql --chmod=444 primary_node/files/BANK_INFO.sql /db_scripts/
ADD --chown=mysql:mysql --chmod=444 primary_node/files/USER_DATA.sql /db_scripts/
ADD --chown=mysql:mysql --chmod=755 primary_node/files/01-replica_user.sh /db_scripts/
ADD --chown=mysql:mysql --chmod=755 primary_node/files/02-run_once.sh /db_scripts/
ADD --chmod=555 primary_node/files/startup.sh /docker-entrypoint-initdb.d/

RUN sed -i /etc/my.cnf -e '/skip-host-cache/d' && chmod o+w /etc && chown mysql:mysql /etc/my.cnf