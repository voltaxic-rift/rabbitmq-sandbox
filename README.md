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
cd el7 # or cd el8
vagrant up --no-parallel
```

## Confirm

```
vagrant ssh rabbitmq-server1 # or 2, 3
sudo -i
rabbitmqctl cluster_status
```

- `http://192.168.57.201:15672` : Management Web UI
    - or `202` , `203`
    - user/password: `admin/hogehogeunko`
