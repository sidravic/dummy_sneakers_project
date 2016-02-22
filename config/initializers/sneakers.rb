Sneakers.configure({
                       :amqp => ENV['CLOUD_AMQP_URL'],
                       :daemonize => false,
                       :log => STDOUT,
                       :exchange_type => 'fanout',
                       :exchange => 'simpl_api_events_development',
                       :durable => false,
                       :worker => 5,
                       :pid => "#{Rails.root}/tmp/pids"
                   })

Sneakers.logger.level = Logger::INFO