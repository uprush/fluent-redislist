module Fluent
  class RedisListOutput < BufferedOutput
    Fluent::Plugin.register_output('redislist', self)
    attr_reader :host, :port, :database, :redis

    def initialize
      super
      require 'redis'
      require 'msgpack'
      require 'socket'
      require 'json'
    end

    def configure(conf)
      super

      @host = conf['host'] || 'localhost'
      @port = ( conf['port'] || '6379' ).to_i
      @database = ( conf['database'] || '0' ).to_i
    end

    def start
      super

      @whereami = Socket.gethostname
      @redis = Redis.new(:host => @host, :port => @port, :db => @database)
    end

    def shutdown
      @redis.quit
    end

    def format(tag, time, record)
      record["@node"] = @whereami
      record["@timestamp"] = Time.at(time).to_s # to avoid LOGSTASH-1340
      record["@key"] = tag
      record.to_msgpack
    end

    def write(chunk)
      @redis.pipelined {
        chunk.open { |io|
          begin
            MessagePack::Unpacker.new(io).each { |record|
              key = record.delete('@key')
              @redis.rpush key, record.to_json
            }
          rescue EOFError
            # EOFError always occured when reached end of chunk.
          end
        }
      }
    end
  end
end
