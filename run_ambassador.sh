#!/bin/sh
docker run -d --link mariadb:mariadb --name="mariadb_ambassador" -p 3306:3306 svendowideit/ambassador
