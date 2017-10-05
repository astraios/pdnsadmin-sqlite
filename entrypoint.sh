#!/bin/sh -x

PDNS_APIKEY=${PDNS_APIKEY:-genericapikey}
PDNS_VERSION=${PDNS_VERSION:-4.0.0}
PDNS_URL=${PDNS_URL:-http://pdns:8081}
SQLITE_DBPATH=${SQLITE_DBPATH:-/powerdns-admin}
SECRET_KEY=${SECRET_KEY:-A72AF848-B75D-402D-BA74-20C50B2BDAED}

# Edit the configuration_template
sed \
  -e "s#\[ replace{'sqlite_path'} \]#${SQLITE_DBPATH}#g" \
  -e "s#\[ replace{'secret_key'} \]#${SECRET_KEY}#g" \
  config_template.py > config.py

# Start POwerDNS-Admin
source ./flask/bin/activate
./create_db.py
./run.py
