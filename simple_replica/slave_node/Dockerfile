FROM mysql:8.0.33-oracle

ADD --chown=mysql:mysql --chmod=444 files/client-cert.pem /certs/
ADD --chown=mysql:mysql --chmod=400 files/client-key.pem /certs/
ADD --chown=mysql:mysql --chmod=444 files/ca.pem /certs/

ADD --chmod=555 scripts/setup.sh /docker-entrypoint-initdb.d/

RUN sed -i /etc/my.cnf -e '/skip-host-cache/d'