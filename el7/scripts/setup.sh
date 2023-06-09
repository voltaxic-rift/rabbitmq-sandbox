#!/bin/bash

set -eux

# RabbitMQ Erlang Version Requirements https://www.rabbitmq.com/which-erlang.html

# https://github.com/rabbitmq/erlang-rpm
# 23.3.4.11: Last release of EL7 Erlang RPM
ERLANG_VERSION="23.3.4.11"
ERLANG_RPM="erlang-$ERLANG_VERSION-1.el7.x86_64.rpm"
# https://github.com/rabbitmq/rabbitmq-server
# 3.9.16: Last release of EL7 RabbitMQ RPM
RABBITMQ_VERSION="3.9.16"
RABBITMQ_RPM="rabbitmq-server-$RABBITMQ_VERSION-1.el7.noarch.rpm"

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

systemctl start rabbitmq-server

sleep 10

pushd /usr/bin
curl -LO localhost:15672/cli/rabbitmqadmin
chmod +x ./rabbitmqadmin
popd

echo "Setup DONE."
