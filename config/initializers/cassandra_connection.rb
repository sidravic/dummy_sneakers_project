require 'cassandra'

class CassandraPool
  attr_reader :cassandra_session, :config

  def initialize()
    @cassandra_session = nil
    @config = YAML.load_file("#{Rails.root}/config/cassandra.yml")[Rails.env.to_s]
  end

  def connect
    cassandra_options = {
        username: config['username'],
        password: config['password'],
        hosts: config['hosts']
    }
    cluster = Cassandra.cluster(cassandra_options)
    @cassandra_session ||= cluster.connect(config['keyspace'])
  end
end

CASSANDRA_POOL = ConnectionPool.new(size: 5, timeouts: 5) { CassandraPool.new.connect }




