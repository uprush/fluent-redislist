Redis List Output Plugin for Fluent
===================================

fluent-redis_list is a fluent plugin to output to redis as list.

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
