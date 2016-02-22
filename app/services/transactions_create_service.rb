class TransactionsCreateService
  attr_reader :transaction

  def initialize(transaction_params)
    @transaction = Transaction.from_params(transaction_params)
  end

  def save
    CASSANDRA_POOL.with do |conn|
      query = "INSERT INTO transactions (id, event_id, status, user_id, merchant_id, amount_in_paise) VALUES (#{transaction.id}, #{transaction.event_id}, '#{transaction.status}', '#{transaction.user_id}', '#{transaction.merchant_id}', #{transaction.amount_in_paise})"

      arguments = {
          id: Cassandra::Uuid.new(transaction.id),
          event_id: transaction.event_id,
          status: transaction.status,
          user_id: transaction.user_id,
          merchant_id: transaction.merchant_id,
          amount_in_paise: transaction.amount_in_paise
      }

      conn.execute(query, consistency: :quorum)
    end
  end
end