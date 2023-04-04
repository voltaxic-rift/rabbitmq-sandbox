#!/bin/bash

set -eux

# https://github.com/rabbitmq/erlang-rpm
ERLANG_VERSION="20.3.8.26"
ERLANG_RPM="erlang-$ERLANG_VERSION-1.el7.x86_64.rpm"
# https://github.com/rabbitmq/rabbitmq-server
RABBITMQ_VERSION="3.6.16"
RABBITMQ_RPM="rabbitmq-server-$RABBITMQ_VERSION-1.el7.noarch.rpm"

CACHE_DIR="/vagrant/cache"

if [ ! -e $CACHE_DIR/$ERLANG_RPM ]; then
    pushd $CACHE_DIR
    curl -LO "https://github.com/rabbitmq/erlang-rpm/releases/download/v$ERLANG_VERSION/$ERLANG_RPM"
    popd
fi

if [ ! -e $CACHE_DIR/$RABBITMQ_RPM ]; then
    pushd $CACHE_DIR
    RABBITMQ_VERSION_UNDERSCORE=$(echo $RABBITMQ_VERSION | sed -re 's/\./_/g')
    curl -LO "https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v$RABBITMQ_VERSION_UNDERSCORE/$RABBITMQ_RPM"
    popd
fi

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
