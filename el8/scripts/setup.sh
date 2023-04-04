#!/bin/bash

set -eux

# https://github.com/rabbitmq/erlang-rpm
ERLANG_VERSION="25.3"
ERLANG_RPM="erlang-$ERLANG_VERSION-1.el8.x86_64.rpm"
# https://github.com/rabbitmq/rabbitmq-server
RABBITMQ_VERSION="3.11.13"
RABBITMQ_RPM="rabbitmq-server-$RABBITMQ_VERSION-1.el8.noarch.rpm"

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

dnf install -y /vagrant/cache/$ERLANG_RPM
dnf install -y /vagrant/cache/$RABBITMQ_RPM

# config example: https://github.com/rabbitmq/rabbitmq-server/blob/v3.11.13/deps/rabbit/docs/rabbitmq.conf.example
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
