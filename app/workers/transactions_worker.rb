class TransactionWorker
  include Sneakers::Worker
  from_queue('default_development_queue',
             durable: false,
             ack: true,
             threads: 10)


  def work(job)
    puts job
    ack!
  end
end
