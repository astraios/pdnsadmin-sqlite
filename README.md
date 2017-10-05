# PowerDNS Admin with sqlite backend

## Build

```
docker build -t yourfavorite/tag .
```

## Usage

### Environment variables

* `SECRET_KEY`: Configure the secret key, event if for now, it's not used anywhere in the code.
* `SQLITE_PATH`: default is `/powerdns-admin` in the container, you can change that, do not forget
to mount the volume in the container
* `PDNS_APIKEY`: PowerDNS API KEY
* `PDNS_VERSION`: PowerDNS version
* `PDNS_URL`: URL to reach a PowerDNS instance 

### Starting the container

#### with docker

```
docker run -d -p 9393:9393 -v $(PWD):/powerdns-admin -e PDNS_APIKEY=somekey -e PDNS_VERSION=4.0.0 -e PDNS_URL=http://somepowerdnsinstance notuscloud/pdnsadmin-sqlite
```

#### with a compose file

```
version: "3"
services:
  pdnsadmin:
    image: notuscloud/pdnsadmin-sqlite:latest
    ports:
      - 9393:9393
    volumes:
      - your/favorite/path:/powerdns-admin
    environment:
      PDNS_APIKEY: somekey
      PDNS_VERSION: 4.0.0
      PDNS_URL: http://somepdnsurl
```

## Acknowlegdment

thanks to ngoduykhanh or it's amazing job: https://github.com/ngoduykhanh/PowerDNS-Admin
