require 'fluent/test'
require 'socket'
require 'json'
require 'redis'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fluent/plugin/out_redislist'

class FileOutputTest < Test::Unit::TestCase
  def setup
    r = Redis.new(:host => "localhost", :port => 6379, :db => 1)
    r.flushall

    Fluent::Test.setup

    @d = create_driver %[
      host localhost
      port 6379
      database 1
    ]
    @time = Time.parse("2013-09-17 13:14:15 UTC").to_i
  end

  def create_driver(conf = CONFIG)
    Fluent::Test::BufferedOutputTestDriver.new(Fluent::RedisListOutput).configure(conf)
  end

  def test_configure
    assert_equal 'localhost', @d.instance.host
    assert_equal 6379, @d.instance.port
    assert_equal 1, @d.instance.database
  end

  def test_format
    whereami = Socket.gethostname
    @d.emit({"a"=>1}, @time)
    @d.expect_format({"a"=>1, "@node" => whereami, "@timestamp" => Time.at(@time).to_s, "@key" => "test"}.to_msgpack)
    @d.run
  end

  def test_write
    @d.emit({"foo" => "bar"}, @time)
    @d.emit({"hoge" => "hellohoge"}, @time)
    @d.run

    redis = @d.instance.redis
    assert_equal 2, redis.llen("test")

    record = JSON.parse(@d.instance.redis.lpop("test"))
    assert_equal "bar", record["foo"]

    record = JSON.parse(@d.instance.redis.lpop("test"))
    assert_equal "hellohoge", record["hoge"]
  end
end
