Docker file for Service Ambassador
==================================

This Docker file wraps [etcd-netfw](https://github.com/nuxeo/etcd-netfw) and may be used for an ambassador to any service that is declared in `etcd`.

This pattern is mainly inspired by this blog post : [http://coreos.com/blog/docker-dynamic-ambassador-powered-by-etcd/]()



To run this ambassador, just use

    docker run --name postgres-service -d -p 1337 nuxeo/service-amb postgres

It will start the ambassador, linking the port 1337.

Now let's say you have a running PostgreSQL on host 172.12.8.101 and port 49154 (hmmm, it seems another container ;-) ). You have to declare that service in etcd like that :

    etcdctl set /services/postgres/1 \{\"host\":\"172.12.8.101\",\"port\":49154\}


Finally it's time to start our client container using a [link](http://docs.docker.io/en/latest/use/working_with_links_names/).

    docker run --rm --link postgres-amb:db -t -i ubuntu bash

    root@36cb307c04fd:/# env
    DB_PORT_1337_TCP_PROTO=tcp
    HOSTNAME=36cb307c04fd
    DB_NAME=/drunk_babbage/db
    TERM=xterm
    DB_PORT=tcp://172.17.0.3:1337
    DB_PORT_1337_TCP_ADDR=172.17.0.3
    DB_PORT_1337_TCP_PORT=1337
    DB_ENV_GOPATH=/usr/local/go/
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    PWD=/
    DB_PORT_1337_TCP=tcp://172.17.0.3:1337
    SHLVL=1
    HOME=/
    _=/usr/bin/env

    root@36cb307c04fd:/# apt-get update && apt-get install postgresql-client

    ...

    root@36cb307c04fd:/# psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U docker postgres


and tada ! you're logged on the targeted PostgreSQL.


