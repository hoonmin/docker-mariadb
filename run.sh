#!/bin/sh
docker run -d --name="mariadb" --volumes-from mariadb_volume -t hoonmin/mariadb
