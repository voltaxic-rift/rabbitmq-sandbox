#!/bin/bash

set -eux

# RabbitMQ Erlang Version Requirements https://www.rabbitmq.com/which-erlang.html

# https://github.com/rabbitmq/erlang-rpm
# 23.1.4: Last release of EL6 Erlang RPM
ERLANG_VERSION="23.1.4"
ERLANG_RPM="erlang-$ERLANG_VERSION-1.el6.x86_64.rpm"

# https://github.com/rabbitmq/rabbitmq-server
# 3.8.9: Last release of EL6 RabbitMQ RPM
RABBITMQ_VERSION="3.8.9"
RABBITMQ_RPM="rabbitmq-server-$RABBITMQ_VERSION-1.el6.noarch.rpm"

CACHE_DIR="/vagrant/cache"

if [ ! -e $CACHE_DIR/$ERLANG_RPM ]; then
    pushd $CACHE_DIR
    curl -LO "https://github.com/rabbitmq/erlang-rpm/releases/download/v$ERLANG_VERSION/$ERLANG_RPM"
    popd
fi

if [ ! -e $CACHE_DIR/$RABBITMQ_RPM ]; then
    pushd $CACHE_DIR
    curl -LO "https://github.com/rabbitmq/rabbitmq-server/releases/download/v$RABBITMQ_VERSION/$RABBITMQ_RPM"
    popd
fi

yum makecache fast
yum install -y /vagrant/cache/$ERLANG_RPM
yum install -y /vagrant/cache/$RABBITMQ_RPM

# config example: /usr/share/doc/rabbitmq-server-$RABBITMQ_VERSION/rabbitmq.config.example
\cp -f /vagrant/rabbitmq_configurations/* /etc/rabbitmq/
\cp -f /vagrant/.erlang.cookie /var/lib/rabbitmq/
chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
chmod 600 /var/lib/rabbitmq/.erlang.cookie

service iptables stop
service rabbitmq-server start

sleep 10

pushd /usr/bin
curl -LO localhost:15672/cli/rabbitmqadmin
chmod +x ./rabbitmqadmin
popd

echo "Setup DONE."
