# RabbitMQ Sandbox

RabbitMQ from our perspective https://dic.pixiv.net/a/%E3%83%AD%E3%83%93%E3%83%BC%E5%90%9B

## Requirements

- libvirt environment
- Vagrant
- Vagrant plugins
    - vagrant-libvirt
    - vagrant-sshfs
- Lots of compute resources
    - CPU, RAM

## Getting started

```
cd el8 # or cd el7, 6
vagrant up --no-parallel
```

## Confirm

```
vagrant ssh rabbitmq-server1 # or 2, 3
sudo -i
rabbitmqctl cluster_status
```

<details>
<summary>New RabbitMQ output example</summary>

```
[root@rabbitmq-server1 ~]# rabbitmqctl cluster_status
Cluster status of node rabbit@rabbitmq-server1 ...
Basics

Cluster name: rabbit@rabbitmq-server1
Total CPU cores available cluster-wide: 6

Disk Nodes

rabbit@rabbitmq-server1
rabbit@rabbitmq-server2
rabbit@rabbitmq-server3

Running Nodes

rabbit@rabbitmq-server1
rabbit@rabbitmq-server2
rabbit@rabbitmq-server3

Versions

rabbit@rabbitmq-server1: RabbitMQ 3.11.13 on Erlang 25.3
rabbit@rabbitmq-server2: RabbitMQ 3.11.13 on Erlang 25.3
rabbit@rabbitmq-server3: RabbitMQ 3.11.13 on Erlang 25.3

CPU Cores

Node: rabbit@rabbitmq-server1, available CPU cores: 2
Node: rabbit@rabbitmq-server2, available CPU cores: 2
Node: rabbit@rabbitmq-server3, available CPU cores: 2

Maintenance status

Node: rabbit@rabbitmq-server1, status: not under maintenance
Node: rabbit@rabbitmq-server2, status: not under maintenance
Node: rabbit@rabbitmq-server3, status: not under maintenance

Alarms

(none)

Network Partitions

(none)

Listeners

Node: rabbit@rabbitmq-server1, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq-server1, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq-server1, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq-server2, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq-server2, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq-server2, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0
Node: rabbit@rabbitmq-server3, interface: [::], port: 15672, protocol: http, purpose: HTTP API
Node: rabbit@rabbitmq-server3, interface: [::], port: 25672, protocol: clustering, purpose: inter-node and CLI tool communication
Node: rabbit@rabbitmq-server3, interface: [::], port: 5672, protocol: amqp, purpose: AMQP 0-9-1 and AMQP 1.0

Feature flags

Flag: classic_mirrored_queue_version, state: enabled
Flag: classic_queue_type_delivery_support, state: enabled
Flag: direct_exchange_routing_v2, state: enabled
Flag: drop_unroutable_metric, state: enabled
Flag: empty_basic_get_metric, state: enabled
Flag: feature_flags_v2, state: enabled
Flag: implicit_default_bindings, state: enabled
Flag: listener_records_in_ets, state: enabled
Flag: maintenance_mode_status, state: enabled
Flag: quorum_queue, state: enabled
Flag: stream_queue, state: enabled
Flag: stream_single_active_consumer, state: enabled
Flag: tracking_records_in_ets, state: enabled
Flag: user_limits, state: enabled
Flag: virtual_host_metadata, state: enabled
```

</details>

<details>
<summary>Old RabbitMQ output example</summary>

```
[root@rabbitmq-server1 ~]# rabbitmqctl cluster_status
Cluster status of node 'rabbit@rabbitmq-server1' ...
[{nodes,[{disc,['rabbit@rabbitmq-server1','rabbit@rabbitmq-server2',
                'rabbit@rabbitmq-server3']}]},
 {running_nodes,['rabbit@rabbitmq-server3','rabbit@rabbitmq-server2',
                 'rabbit@rabbitmq-server1']},
 {partitions,[]}]
...done.
```

</details>

- `http://192.168.57.201:15672` : Management Web UI
    - or `202` , `203`
    - user/password: `admin/hogehogeunko`
