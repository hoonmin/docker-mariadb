#!/bin/sh
docker run -d -v /var/lib/mysql --name mariadb_volume hoonmin/mariadb echo Data Volume Container for MariaDB
