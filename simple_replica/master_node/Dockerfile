FROM mysql:8.0.33-oracle

ADD --chmod=644 files/01-ssl.cnf /etc/mysql/conf.d/
ADD --chown=mysql:mysql files/*.pem /etc/mysql/certs/

ADD --chmod=555 scripts/01-setup.sh /docker-entrypoint-initdb.d/
ADD --chown=mysql:mysql scripts/BANK_INFO.sql /db_scripts/
ADD --chown=mysql:mysql scripts/USER_DATA.sql /db_scripts/

ADD --chmod=555 scripts/db-populate.sh /db_scripts/

RUN sed -i /etc/my.cnf -e '/skip-host-cache/d'
