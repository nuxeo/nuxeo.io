
cat << EOF >> $NUXEO_HOME/bin/nuxeo.conf
nuxeo.url=http://`etcdctl -C 172.17.42.1:4001 get /envs/$ENV_TECH_ID/domain`
EOF

exec "$@"
