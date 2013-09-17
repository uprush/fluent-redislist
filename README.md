Redis List Output Plugin for Fluent
===================================

fluent-redislist is a fluent plugin to output to redis as list.

Installation
------------

Install via gem:

    gem install fluent-redislist

Configuration
-------------

    <match rl.**>
      type rl
      host localhost
      port 6379
      database 0
    </match>

Usage
-----
fluent-redislist outputs record to redis as list with json format. Sample output as follows:

    redis 127.0.0.1:6379> lpop "rl.apache_access"
    "{\"host\":\"40.30.51.109\",\"user\":null,\"method\":\"GET\",\"path\":\"/item/computers/4487\",\"code\":200,\"size\":85,\"referer\":\"/category/office\",\"agent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0.1) Gecko/20100101 Firefox/9.0.1\",\"@node\":\"vagrant-ubuntu-raring-64\",\"@timestamp\":1379386921,\"@type\":\"rl.apache_access\"}"
