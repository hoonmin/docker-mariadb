FROM ubuntu:14.04

# Install Runit
RUN apt-get update && \
    apt-get install -y runit

# Add runit service configs to /etc/service
ADD runit /etc/service

# Install MariaDB
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
  rm -rf /var/lib/apt/lists/* && \
  rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf

# Setup MariaDB
ADD maria.ddl /maria.ddl
RUN mysqld_safe & mysqladmin --wait=5 ping && \
    mysql < /maria.ddl && \
    mysqladmin shutdown
RUN echo "mysqld: ALL" >> /etc/hosts.allow

# Define mountable directories
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define default command
CMD ["/usr/sbin/runsvdir-start"]

# Expose ports.
EXPOSE 3306
